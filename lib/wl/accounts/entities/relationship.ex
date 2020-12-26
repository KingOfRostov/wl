defmodule Wl.Accounts.Entities.Relationship do
  use Ecto.Schema

  import Ecto.Changeset
  alias Wl.Accounts.Entities.User

  @preload_list [:followed_id, :follower_id]
  @required [:followed_id, :follower_id]
  @optional [:followed_id, :follower_id, :archived_at]
  schema "relationships" do
    belongs_to :followed, User
    belongs_to :follower, User
    field :archived_at, :naive_datetime
    timestamps()
  end

  def changeset(relationship, attrs \\ %{}) do
    relationship
    |> cast(attrs, @optional ++ @required)
    |> validate_required(@required)
  end

  def preload_list, do: @preload_list
end
