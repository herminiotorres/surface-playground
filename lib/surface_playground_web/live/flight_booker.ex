defmodule SurfacePlaygroundWeb.FlightBooker do
  use SurfacePlaygroundWeb, :surface_view

  alias SurfacePlayground.FlightTickets
  alias Surface.Components.Form
  alias Surface.Components.Form.Field
  alias Surface.Components.Form.Select
  alias Surface.Components.Form.TextInput
  alias Surface.Components.Form.ErrorTag
  alias Surface.Components.Form.Submit

  data changeset, :changeset, default: FlightTickets.new_booking_changes()
  data flight_types, :map, default: FlightTickets.flight_types()

  def render(assigns) do
    ~F"""
    <div class="container">
      <h1>Book Flight</h1>
      <Form for={@changeset} submit="book" change="validate" opts={id: "flight-booker"}>
        <Field name={:flight_type}>
          <Select options={@flight_types} opts={id: "flight-type"} />
        </Field>

        <Field name={:departure}>
          <TextInput class={date_class(@changeset, :departure)} />
          <ErrorTag class="invalid-feedback" />
        </Field>

        <Field name={:return}>
          <TextInput class={date_class(@changeset, :return)} opts={id: "return-date", disabled: one_way_flight?(@changeset)} />
          <ErrorTag class="invalid-feedback" />
        </Field>

        <Field name={:date_mismatch}>
          <ErrorTag class="invalid-feedback" />
        </Field>

        <Submit label="Book" opts={id: "book-flight", disabled: !@changeset.valid?} />
      </Form>
    </div>

    <hr>

    <h3>References:</h3>
    <div class="row">
      <ul>
        <li>
          <a href="https://www.germanvelasco.com/blog/seven-guis-flight-booker" target="_blank">German Velasco Blog Post</a>
        </li>
        <li>
          <a href="https://github.com/germsvel/gui-examples" target="_blank">German Velasco Github Repository</a>
        </li>
      </ul>
    </div>
    """
  end

  def handle_event("validate", %{"booking" => params}, socket) do
    changeset = FlightTickets.change_booking(socket.assigns.changeset, params)

    socket
    |> assign(:changeset, changeset)
    |> noreply()
  end

  def handle_event("book", %{"booking" => params}, socket) do
    {:ok, message} =
      socket.assigns.changeset
      |> FlightTickets.change_booking(params)
      |> FlightTickets.book_trip()

    socket
    |> put_flash(:info, message)
    |> noreply()
  end

  defp date_class(changeset, field) do
    if changeset.errors[field] do
      "invalid-feedback"
    end
  end

  defp one_way_flight?(changeset) do
    FlightTickets.one_way?(changeset.changes)
  end

  defp noreply(socket), do: {:noreply, socket}
end
