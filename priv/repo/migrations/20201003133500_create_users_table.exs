defmodule Wl.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :surname, :string
      add :username, :string
      add :password_hash, :string
      add :profile_photo, :string

      timestamps()
    end

    create unique_index(:users, [:username])
  end
end
