defmodule Wl.Repo.Migrations.AddFollowersAndFollowedNumbersToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :followers_number, :integer, default: 0
      add :followed_number, :integer, default: 0
    end
  end
end
