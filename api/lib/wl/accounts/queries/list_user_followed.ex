defmodule Wl.Accounts.Queries.ListUserFollowed do
  alias Wl.Accounts.Entities.{Relationship, User}
  alias Wl.Repo
  import Ecto.Query

  def process(user_id) do
    relationships_subquery =
      from r in Relationship,
        where: is_nil(r.archived_at) and r.follower_user_id == ^user_id,
        select: %{followed_user_id: r.followed_user_id, inserted_at: r.inserted_at}

    followed_query =
      from u in User,
        join: rs in subquery(relationships_subquery),
        on: u.id == rs.followed_user_id,
        order_by: {:asc, rs.inserted_at}

    Repo.all(followed_query)
  end
end
