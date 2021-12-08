defmodule SurfacePlayground.Repo do
  use Ecto.Repo,
    otp_app: :surface_playground,
    adapter: Ecto.Adapters.Postgres
end
