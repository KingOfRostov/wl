defmodule Wl.Accounts.Queries.GetUserByUsername do
  alias Wl.Accounts.Entities.User
  alias Wl.Repo

  def process(username) do
    Repo.get_by(User, username: username)
  end
end
