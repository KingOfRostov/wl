defmodule Wl.Accounts.Queries.Filters.UserFilter.FollowerUser do
  import Ecto.Query
  alias Wl.Accounts.Entities.Relationship

  def add_query(query, nil), do: query

  def add_query(query, follower_user_id) do
    relationships_subquery =
      from r in Relationship,
        where: is_nil(r.archived_at) and r.followed_user_id == ^follower_user_id,
        select: %{follower_user_id: r.follower_user_id}

    query
    |> join(:inner, [{:user, u}], rs in subquery(relationships_subquery),
      on: u.id == rs.follower_user_id,
      as: :follower_relation
    )
  end
end
