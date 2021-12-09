defmodule SurfacePlaygroundWeb.Counter do
  use Surface.LiveView

  data count, :integer, default: 0

  def render(assigns) do
    ~F"""
    <div class="container">
      <h1 class="title">Counter</h1>
      <p>
        {@count}
      </p>
      <p>
        <button class="button if-info" :on-click="increment">
          count
        </button>
      </p>
    </div>
    """
  end

  def handle_event("increment", _, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end
end
