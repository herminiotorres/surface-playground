defmodule SurfacePlaygroundWeb.TemperatureLive do
  use SurfacePlaygroundWeb, :surface_view

  alias Surface.Components.Form
  alias Surface.Components.Form.Field
  alias Surface.Components.Form.Label
  alias Surface.Components.Form.TextInput

  data celsius, :integer, default: 0
  data fahrenheit, :integer, default: 32

  def render(assigns) do
    ~F"""
    <div class="container">
      <h1>Temperature Converter</h1>

      <Form for={:temperature} change="temperature">
        <Field name="celsius">
          <Label/>
          <TextInput value={@celsius} />
        </Field>
        <Field name="fahrenheit">
          <Label>Fahrenheit</Label>
          <TextInput value={@fahrenheit} />
        </Field>
      </Form>
    </div>

    <hr>

    <h3>References:</h3>
    <div class="row">
      <ul>
        <li>
          <a href="https://www.germanvelasco.com/blog/seven-guis-temperature" target="_blank">German Velasco Blog Post</a>
        </li>
        <li>
          <a href="https://github.com/germsvel/gui-examples" target="_blank">German Velasco Github Repository</a>
        </li>
      </ul>
    </div>
    """
  end

  def handle_event(
        "temperature",
        %{"temperature" => %{"celsius" => celsius, "fahrenheit" => fahrenheit}} = params,
        socket
      ) do
    ["temperature", target] = params["_target"]
    calculate_temperature(target, socket, fahrenheit, celsius)
  end

  defp calculate_temperature("fahrenheit", socket, temperature, _) do
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

  defp calculate_temperature("celsius", socket, _, temperature) do
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
