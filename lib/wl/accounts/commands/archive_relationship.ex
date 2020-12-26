defmodule Wl.Accounts.Commands.ArchiveRelationship do
  alias Wl.Accounts.Entities.Relationship
  alias Wl.Repo
  import Ecto.Query

  def process(%{follower_user_id: follower_user_id, followed_user_id: followed_user_id}) do
    relationship_query =
      from r in Relationship,
        where:
          r.follower_user_id == ^follower_user_id and
            r.followed_user_id == ^followed_user_id and
            is_nil(r.archived_at)

    case Repo.one(relationship_query) do
      nil ->
        {:error, "Already unfollowed"}

      relationship ->
        relationship
        |> Relationship.update_relationship_changeset(%{archived_at: NaiveDateTime.utc_now()})
        |> Repo.update()
    end
  end
end
