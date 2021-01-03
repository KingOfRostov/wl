defmodule Wl.Accounts.Queries.GetUsernameById do
  import Ecto.Query
  alias Wl.Accounts.Entities.User
  alias Wl.Repo
  def process(nil), do: nil

  def process(id) do
    query = from(u in User, where: u.id == ^id, select: u.username)
    Repo.one(query)
  end
end
