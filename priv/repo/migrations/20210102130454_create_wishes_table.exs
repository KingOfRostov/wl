defmodule Wl.Repo.Migrations.CreateWishesTable do
  use Ecto.Migration

  def change do
    create table(:wishes) do
      add :name, :string
      add :description, :text
      add :image, :string
      add :archived_at, :naive_datetime
      add :user_id, references(:users)
      timestamps()
    end

    create index(:wishes, [:user_id])
  end
end
