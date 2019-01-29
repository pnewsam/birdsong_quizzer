use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :birdsong_quizzer, BirdsongQuizzerWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :birdsong_quizzer, BirdsongQuizzer.Repo,
  username: "postgres",
  password: "postgres",
  database: "birdsong_quizzer_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
