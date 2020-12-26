defmodule Wl.Repo.Migrations.CreateRelationshipsTable do
  use Ecto.Migration

  def change do
    create table(:relationships) do
      add :followed_id, references(:users), null: false
      add :follower_id, references(:users), null: false
      add :archived_at, :naive_datetime
      timestamps()
    end

    create index(:relationships, [:followed_id])
    create index(:relationships, [:follower_id])
  end
end
