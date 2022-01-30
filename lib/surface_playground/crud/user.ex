defmodule SurfacePlayground.CRUD.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :first_name, :string, null: false
    field :last_name, :string, null: false

    timestamps()
  end

  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:first_name, :last_name])
    |> validate_required([:first_name, :last_name])
  end
end
