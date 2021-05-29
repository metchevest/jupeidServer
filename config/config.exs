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

config :juserver, Juserver.Auth.Guardian,
  issuer: "juserver",
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  ttl: {30, :days},
  allowed_drift: 2000,
  verify_issuer: true,
  secret_key: "7FMmhHrfYuuFqjfIwyzfN3O+fIGJ3qYUe2SfoK/ZLF/lqmnvwVc/UqRBNyOg/XJd"

# config :cors_plug,
#   origin: ["http://localhost:3000/", "localhost:3000"],
#   max_age: 86400,
#   credentials: true,
# send_preflight_response?: true

# methods: ["GET", "POST"]

# allowed_algos: ["HS512"],
# # optional
# verify_module: Guardian.JWT,
# issuer: "BlogAppGql",
# ttl: {30, :days},
# allowed_drift: 2000,
# # optional
# verify_issuer: true,
# # generated using: JOSE.JWK.generate_key({:oct, 16}) |> JOSE.JWK.to_map |> elem(1)
# secret_key: %{"k" => "3gx0vXjUD2BJ8xfo_aQWIA", "kty" => "oct"},
# serializer: BlogAppGql.Guardian
