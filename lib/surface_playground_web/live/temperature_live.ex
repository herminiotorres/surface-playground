defmodule SurfacePlaygroundWeb.TemperatureLive do
  use Surface.LiveView,
    layout: {SurfacePlaygroundWeb.LayoutView, "live.html"}

  data celsius, :integer, default: 0
  data fahrenheit, :integer, default: 32

  def render(assigns) do
    ~F"""
    <div class="container">
      <h1>Temperature Converter</h1>

      <div>
        <form action="#" id="celsius" :on-change={"to_fahrenheit"}>
          <label for="celsius">Celsius</label>
          <input type="text" name="celsius" value={@celsius} />
        </form>

      </div>
      <div>
        <form action="#" id="fahrenheit" :on-change={"to_celsius"}>
          <label for="fahrenheit">Fahrenheit</label>
          <input type="text" name="fahrenheit" value={@fahrenheit} />
        </form>
      </div>
    </div>
    """
  end

  def handle_event("to_celsius", %{"fahrenheit" => temperature}, socket) do
    case Float.parse(temperature) do
      {fahrenheit, ""} ->
        celsius = SurfacePlayground.Temperature.to_celsius(fahrenheit)

        {:noreply, assign(socket, celsius: celsius, fahrenheit: fahrenheit)}

      {fahrenheit, "."} ->
        celsius = SurfacePlayground.Temperature.to_celsius(fahrenheit)

        {:noreply, assign(socket, celsius: celsius, fahrenheit: fahrenheit)}

      _error ->
        socket = put_flash(socket, :error, "Fahrenheit must be a number")

        {:noreply, socket}
    end
  end

  def handle_event("to_fahrenheit", %{"celsius" => temperature}, socket) do
    case Float.parse(temperature) do
      {celsius, ""} ->
        fahrenheit = SurfacePlayground.Temperature.to_fahrenheit(celsius)

        {:noreply, assign(socket, celsius: celsius, fahrenheit: fahrenheit)}

      {celsius, "."} ->
        fahrenheit = SurfacePlayground.Temperature.to_fahrenheit(celsius)

        {:noreply, assign(socket, celsius: celsius, fahrenheit: fahrenheit)}

      _error ->
        socket = put_flash(socket, :error, "Celsius must be a number")

        {:noreply, socket}
    end
  end
end
