defmodule SurfacePlaygroundWeb.Counter do
  use SurfacePlaygroundWeb, :surface_view

  alias SurfacePlaygroundWeb.Components.Button

  data count, :integer, default: 0

  def render(assigns) do
    ~F"""
    <div class="container">
      <h1 class="title">Counter</h1>
      <p>
        {@count}
      </p>
      <p>
        <Button label="count" class="button" click="increment" opts={type: "button"} />
      </p>

      <hr>

      <h3>References:</h3>
      <div class="row">
        <ul>
          <li>
            <a href="https://www.germanvelasco.com/blog/seven-guis-counter" target="_blank">German Velasco Blog Post</a>
          </li>
          <li>
            <a href="https://github.com/germsvel/gui-examples" target="_blank">German Velasco Github Repository</a>
          </li>
        </ul>
      </div>
    </div>
    """
  end

  def handle_event("increment", _, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end
end
