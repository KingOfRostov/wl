defmodule Wl.Repo.Migrations.AddArchivedAtFieldToUsersTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :archived_at, :naive_datetime
    end
  end
end
