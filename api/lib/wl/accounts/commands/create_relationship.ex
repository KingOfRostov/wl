defmodule Wl.Accounts.Commands.CreateRelationship do
  alias Wl.Accounts.Entities.{Relationship, User}
  alias Wl.Repo
  import Ecto.Query

  def process(%{follower_user_id: follower_user_id, followed_user_id: followed_user_id} = attrs) do
    Repo.transaction(fn ->
      follower_user_query = from u in User, where: u.id == ^follower_user_id
      followed_user_query = from u in User, where: u.id == ^followed_user_id
      Repo.update_all(follower_user_query, inc: [followed_number: 1])
      Repo.update_all(followed_user_query, inc: [followers_number: 1])

      %Relationship{}
      |> Relationship.new_relationship_changeset(attrs)
      |> Repo.insert()
    end)
  end
end
