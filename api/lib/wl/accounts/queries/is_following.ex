defmodule Wl.Accounts.Queries.IsFollowing do
  alias Wl.Accounts.Entities.Relationship
  alias Wl.Repo
  import Ecto.Query

  def process(follower_user_id, followed_user_id) do
    query =
      from r in Relationship,
        where:
          r.follower_user_id == ^follower_user_id and r.followed_user_id == ^followed_user_id and
            is_nil(r.archived_at),
        select: 1

    case Repo.one(query) do
      nil -> false
      _ -> true
    end
  end
end
