defmodule Wl.Accounts.Queries.GetUser do
  alias Wl.Accounts.Entities.User
  alias Wl.Properties.Entities.Wish
  alias Wl.Repo
  import Ecto.Query

  def process(id) do
    wish_subquery =
      from(w in Wish,
        where: is_nil(w.archived_at)
      )

    query =
      from(u in User,
        where: u.id == ^id and is_nil(u.archived_at),
        preload: [wishes: ^wish_subquery]
      )

    Repo.one(query)
  end
end
