defmodule Wl.Accounts.Queries.ListUserFollowers do
  alias Wl.Accounts.Entities.{Relationship, User}
  alias Wl.Repo
  import Ecto.Query

  def process(user_id) do
    relationships_subquery =
      from r in Relationship,
        where: is_nil(r.archived_at) and r.followed_user_id == ^user_id,
        select: %{follower_user_id: r.follower_user_id, inserted_at: r.inserted_at}

    followers_query =
      from u in User,
        join: rs in subquery(relationships_subquery),
        on: u.id == rs.follower_user_id,
        order_by: {:asc, rs.inserted_at}

    Repo.all(followers_query)
  end
end
