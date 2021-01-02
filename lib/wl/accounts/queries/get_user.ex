defmodule Wl.Accounts.Queries.GetUser do
  alias Wl.Accounts.Entities.User
  alias Wl.Repo
  import Ecto.Query

  def process(id) do
    query =
      from u in User, where: u.id == ^id and is_nil(u.archived_at), preload: ^User.preload_list()

    Repo.one(query)
  end
end
