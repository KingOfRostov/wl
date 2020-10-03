defmodule Wl.Accounts.Queries.ListUsers do
  alias Wl.Accounts.Entities.User
  alias Wl.Repo
  import Ecto.Query

  def process do
    query = from u in User, where: is_nil(u.archived_at)
    Repo.all(query)
  end
end
