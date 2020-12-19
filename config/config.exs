# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :wl,
  ecto_repos: [Wl.Repo]

# Configures the endpoint
config :wl, WlWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kDcAFR+xYGUsL4Zsq5qAATOWBJj97zqM19OWUmDaWxadj2Rb6poT3VEeLahUbPmb",
  render_errors: [view: WlWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Wl.PubSub,
  live_view: [signing_salt: "wuoa7xfM"]

config :arc,
  storage: Arc.Storage.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
