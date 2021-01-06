defmodule Wl.Accounts.Commands.ArchiveRelationship do
  alias Wl.Accounts.Entities.{Relationship, User}
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
        Repo.transaction(fn ->
          follower_user_query = from u in User, where: u.id == ^follower_user_id
          followed_user_query = from u in User, where: u.id == ^followed_user_id
          Repo.update_all(follower_user_query, inc: [followed_number: -1])
          Repo.update_all(followed_user_query, inc: [followers_number: -1])

          relationship
          |> Relationship.update_relationship_changeset(%{archived_at: NaiveDateTime.utc_now()})
          |> Repo.update()
        end)
    end
  end
end
