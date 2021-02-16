# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :juserver,
  ecto_repos: [Juserver.Repo]

# Configures the endpoint
config :juserver, JuserverWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YmJXpKnYT0BoAOU49ZUnvs/dV18zyNLFoJAKEbs8dXvslaJvI8vhaWVIITJDiBeg",
  render_errors: [view: JuserverWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Juserver.PubSub,
  live_view: [signing_salt: "ni6RHxju"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
