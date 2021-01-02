defmodule Wl.Properties.Commands.ArchiveWish do
  alias Wl.Properties.Entities.Wish
  alias Wl.Repo

  def process(wish) do
    wish
    |> Wish.changeset(%{archived_at: NaiveDateTime.utc_now()})
    |> Repo.update()
  end
end
