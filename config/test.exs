import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :surface_playground, SurfacePlayground.Repo,
  username: "postgres",
  password: "postgres",
  database: "surface_playground_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :surface_playground, SurfacePlaygroundWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "wGxpGLx8v2BFLGMslfUiHZn7gOcuyou15osimDdPGaz1HBtLVNxk4n8DmLLM2yDE",
  server: false

# In test we don't send emails.
config :surface_playground, SurfacePlayground.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
