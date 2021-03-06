defmodule SurfacePlayground.CRUD do
  alias SurfacePlayground.Repo
  alias SurfacePlayground.CRUD.User

  def new_user_changes, do: {:new_user, User.changeset(%User{})}

  def selected_user_changes(%User{} = user), do: {:selected_user, user, User.changeset(user)}

  def user_changes({:new_user, _changeset}, params) do
    new_user =
      %User{}
      |> User.changeset(params)
      |> Map.put(:action, :insert)

    {:new_user, new_user}
  end

  def user_changes({:selected_user, user, _changeset}, params) do
    selected_user =
      user
      |> User.changeset(params)
      |> Map.put(:action, :update)

    {:selected_user, user, selected_user}
  end

  def list_users do
    Repo.all(User)
  end

  def create_user({:new_user, changeset}) do
    case Repo.insert(changeset) do
      {:ok, _user} = success -> success
      {:error, changeset} -> {:error, {:new_user, changeset}}
    end
  end

  def update_user({:selected_user, user, changeset}) do
    case Repo.update(changeset) do
      {:ok, _user} = success -> success
      {:error, changeset} -> {:error, {:selected_user, user, changeset}}
    end
  end

  def delete_user({:selected_user, user, _changeset}), do: Repo.delete(user)
end
