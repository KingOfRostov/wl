defmodule Wl.Accounts.Queries.Filters.UserFilter.Filter do
  alias Wl.Accounts.Queries.Filters.UserFilter.{FollowedUser, FollowerUser, Search}

  def add_query(query, %{
        search: search,
        followed_user_id: followed_user_id,
        follower_user_id: follower_user_id
      }) do
    query
    |> Search.add_query(search)
    |> FollowedUser.add_query(followed_user_id)
    |> FollowerUser.add_query(follower_user_id)
  end

  def add_query(query, _), do: query
end
