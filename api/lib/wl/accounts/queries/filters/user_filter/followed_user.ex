defmodule Wl.Accounts.Queries.Filters.UserFilter.FollowedUser do
  import Ecto.Query
  alias Wl.Accounts.Entities.Relationship

  def add_query(query, nil), do: query

  def add_query(query, followed_user_id) do
    relationships_subquery =
      from r in Relationship,
        where: is_nil(r.archived_at) and r.follower_user_id == ^followed_user_id,
        select: %{followed_user_id: r.followed_user_id}

    query
    |> join(:inner, [{:user, u}], rs in subquery(relationships_subquery),
      on: u.id == rs.followed_user_id,
      as: :followed_relation
    )
  end
end
