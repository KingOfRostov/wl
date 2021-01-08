defmodule Wl.Repo.Migrations.CreateRelationshipsTable do
  use Ecto.Migration

  def up do
    create table(:relationships) do
      add :followed_user_id, references(:users), null: false
      add :follower_user_id, references(:users), null: false
      add :archived_at, :naive_datetime
      timestamps()
    end

    create index(:relationships, [:followed_user_id])
    create index(:relationships, [:follower_user_id])

    create index(:relationships, [:followed_user_id, :follower_user_id],
             where: "archived_at is null",
             unique: true
           )
  end

  def down do
    drop index(:relationships, [:followed_user_id])
    drop index(:relationships, [:follower_user_id])
    drop index(:relationships, [:followed_user_id, :follower_user_id])
    drop table(:relationships)
  end
end
