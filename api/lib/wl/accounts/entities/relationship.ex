defmodule Wl.Accounts.Entities.Relationship do
  use Ecto.Schema

  import Ecto.Changeset
  alias Wl.Accounts.Entities.User

  @preload_list [:followed_user_id, :follower_user_id]
  @new_relationship_required [:followed_user_id, :follower_user_id]
  @new_relationship_optional [:followed_user_id, :follower_user_id]
  @update_relationship_optional [:archived_at]
  schema "relationships" do
    belongs_to :followed_user, User
    belongs_to :follower_user, User
    field :archived_at, :naive_datetime
    timestamps()
  end

  def new_relationship_changeset(relationship, attrs \\ %{}) do
    relationship
    |> cast(attrs, @new_relationship_optional ++ @new_relationship_required)
    |> validate_required(@new_relationship_required)
    |> unique_constraint([:followed_user_id, :follower_user_id],
      name: :relationships_followed_user_id_follower_user_id_index,
      message: "Already followed"
    )
  end

  def update_relationship_changeset(relationship, attrs \\ %{}) do
    relationship
    |> cast(attrs, @update_relationship_optional ++ @new_relationship_required)
  end

  def preload_list, do: @preload_list
end
