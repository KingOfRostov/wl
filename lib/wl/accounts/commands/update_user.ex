defmodule Wl.Accounts.Commands.UpdateUser do
  alias Wl.Accounts.Entities.User
  alias Wl.Repo

  def process(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end
end
