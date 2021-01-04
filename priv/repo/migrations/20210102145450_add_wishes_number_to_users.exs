defmodule Wl.Repo.Migrations.AddWishesNumberToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :wishes_number, :integer, default: 0
    end
  end
end
