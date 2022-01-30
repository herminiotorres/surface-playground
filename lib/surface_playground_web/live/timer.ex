defmodule SurfacePlaygroundWeb.Timer do
  use SurfacePlaygroundWeb, :surface_view

  alias Surface.Components.Form.Label
  alias Surface.Components.Form.Field
  alias SurfacePlaygroundWeb.Components.Slider
  alias SurfacePlaygroundWeb.Components.Meter
  alias SurfacePlaygroundWeb.Components.Button


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
        <Button label="reset" class="button" click="reset" opts={type: "button"} />
      </Field>

      <hr>

      <h3>References:</h3>
      <div class="row">
        <ul>
          <li>
            <a href="https://www.germanvelasco.com/blog/seven-guis-timer" target="_blank">German Velasco Blog Post</a>
          </li>
          <li>
            <a href="https://github.com/germsvel/gui-examples" target="_blank">German Velasco Github Repository</a>
          </li>
        </ul>
      </div>
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
