defmodule Wl.Repo do
  use Ecto.Repo,
    otp_app: :wl,
    adapter: Ecto.Adapters.Postgres

  use Scrivener
end
