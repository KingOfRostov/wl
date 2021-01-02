defmodule Wl.Properties.Entities.Wish do
  use Ecto.Schema
  use Arc.Ecto.Schema

  import Ecto.Changeset
  alias Wl.Accounts.Entities.User
  alias Wl.ImageUploader

  @preload_list [:user]
  @required [:user_id, :name]
  @optional [:archived_at, :image, :description]
  schema "wishes" do
    field :name, :string
    field :description, :string
    field :image, ImageUploader.Type
    field :archived_at, :naive_datetime
    belongs_to :user, User
    timestamps()
  end

  def changeset(user, attrs \\ %{}) do
    attrs = ImageUploader.with_files(attrs, ["image"])

    user
    |> cast(attrs, @optional ++ @required)
    |> cast_attachments(attrs, [:image])
    |> validate_required(@required)
  end

  def preload_list, do: @preload_list
end
