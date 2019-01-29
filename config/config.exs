# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :birdsong_quizzer,
  ecto_repos: [BirdsongQuizzer.Repo]

# Configures the endpoint
config :birdsong_quizzer, BirdsongQuizzerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kXJf6h6w7VTSLbKad3KefI7aRYTvZGCxAtrggQReI9iEPG0o2HTC/4SeU+7VCr9z",
  render_errors: [view: BirdsongQuizzerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: BirdsongQuizzer.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
