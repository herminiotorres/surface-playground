defmodule SurfacePlaygroundWeb.PageLive do
  use Surface.LiveView

  alias Surface.Components.LiveRedirect
  alias SurfacePlaygroundWeb.Router.Helpers, as: Routes

  def mount(_, _, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~F"""
    <section class="phx-hero">
      <h1>Welcome to <a href="https://github.com/herminiotorres/surface_playground" target="_blank">Surface Playground</a></h1>
      <p>A place where all can learn about surface. I reimplemented a few others liveview examples.</p>
    </section>

    <main class="container">
      <section class="row">
        <article class="column">
          <h2>7 GUIs:</h2>
          <ul>
            <li>
              <LiveRedirect to={Routes.live_path(@socket, SurfacePlaygroundWeb.Counter)}>
              Implementing a Counter in LiveView
              </LiveRedirect>
            </li>
            <li>
              <LiveRedirect to={Routes.live_path(@socket, SurfacePlaygroundWeb.TemperatureLive)}>
              Implementing a Temperature Converter in LiveView
              </LiveRedirect>
            </li>
            <li>
              <LiveRedirect to={Routes.live_path(@socket, SurfacePlaygroundWeb.FlightBooker)}>
              Implementing a Flight Booker in LiveView
              </LiveRedirect>
            </li>
            <li>
              <LiveRedirect to={Routes.live_path(@socket, SurfacePlaygroundWeb.Timer)}>
                Implementing an Interactive Timer in LiveView
              </LiveRedirect>
            </li>
          </ul>
        </article>
      </section>
    </main>
    """
  end
end
