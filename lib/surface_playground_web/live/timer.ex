defmodule SurfacePlaygroundWeb.Timer do
  use Surface.LiveView

  alias Surface.Components.Form.Label
  alias Surface.Components.Form.Field
  alias Surface.Components.Link.Button
  alias SurfacePlaygroundWeb.Components.Slider
  alias SurfacePlaygroundWeb.Components.Meter

  data elapsed_time, :integer, default: 0
  data duration, :integer, default: 50

  def render(assigns) do
    ~F"""
    <div class="container">
      <h1>Timer</h1>

      <Field name="elapsed-time-gauge">
        <Label opts={for: "elapsed-time-gauge"}>Elapsed Time:</Label>
        <Meter label={@elapsed_time} id="elapsed-time-gauge" name="elapsed-time-gauge" opts={min: "0", value: @elapsed_time, max: @duration} />
      </Field>

      <div id="elapsed-time">
        {@elapsed_time} s
      </div>

      <Field name="duration-slider">
        <Label opts={for: "duration-slider"}>Duration:</Label>
        <Slider type="range" id="duration-slider" name="duration-slider" opts={min: "0", max: "100", step: "1"} />
      </Field>

      <Field name="reset">
        <Button to="#" method={nil} label="reset" id="reset" opts={type: "button", phx_click: "reset"} />
      </Field>
    </div>
    """
  end

  def mount(_, _, socket) do
    if connected?(socket), do: schedule_timer()

    {:ok, socket}
  end

  def handle_info(:tick, socket) do
    elapsed_time = socket.assigns.elapsed_time
    duration = socket.assigns.duration

    if elapsed_time < duration do
      socket
      |> update(:elapsed_time, fn time -> time + 1 end)
      |> noreply()
    else
      noreply(socket)
    end
  end

  def handle_event("update-duration", %{"value" => value}, socket) do
    socket
    |> assign(:duration, String.to_integer(value))
    |> noreply()
  end

  def handle_event("reset", _, socket) do
    socket
    |> assign(:elapsed_time, 0)
    |> noreply()
  end

  defp schedule_timer do
    :timer.send_interval(1_000, :tick)
  end

  defp noreply(socket), do: {:noreply, socket}
end
