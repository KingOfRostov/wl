defmodule Wl.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      # Start the Ecto repository
      Wl.Repo,
      # Start the Telemetry supervisor
      WlWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Wl.PubSub},
      # Start the Endpoint (http/https)
      WlWeb.Endpoint,
      supervisor(Wl.Accounts.Services.SessionStorage, [])
      # Start a worker by calling: Wl.Worker.start_link(arg)
      # {Wl.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Wl.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    WlWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
