defmodule SurfacePlayground.Booking do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :flight_type, :string
    field :departure, :date
    field :return, :date
  end

  def flight_types, do: ["one-way flight", "return flight"]
  def required_fields, do: [:flight_type, :departure]
  def optional_fields, do: [:return]

  def changeset(booking, %{"flight_type" => flight_type} = params) do
    case flight_type do
      "one-way flight" -> one_way_flight_changeset(booking, params)
      "return flight" -> return_flight_changeset(booking, params)
    end
  end

  def one_way_flight_changeset(booking, params \\ %{"flight_type" => "one-way flight"}) do
    booking
    |> cast(params, required_fields())
    |> validate_required(required_fields())
    |> validate_inclusion(:flight_type, ["one-way flight"])
  end

  def return_flight_changeset(booking, params \\ %{"flight_type" => "return flight"}) do
    booking
    |> cast(params, required_fields() ++ optional_fields())
    |> validate_required(required_fields() ++ optional_fields())
    |> validate_inclusion(:flight_type, ["return flight"])
    |> validate_return_and_departure()
  end

  defp validate_return_and_departure(changeset) do
    departure = get_field(changeset, :departure)
    return = get_field(changeset, :return)

    if departure && return && Date.compare(departure, return) != :lt do
      add_date_mismatch_if_last_error(changeset)
    else
      changeset
    end
  end

  defp add_date_mismatch_if_last_error(changeset) do
    if Enum.empty?(changeset.errors) do
      add_error(changeset, :date_mismatch, "must be after departure date")
    else
      changeset
    end
  end
end
