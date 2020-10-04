defmodule Wl.Accounts.Commands.ArchiveUser do
  alias Wl.Accounts.Entities.User
  alias Wl.Repo

  def process(user) do
    user
    |> User.changeset(%{archived_at: NaiveDateTime.utc_now()})
    |> Repo.update()
  end
end
