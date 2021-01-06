defmodule Wl.Properties.Queries.GetWish do
  alias Wl.Properties.Entities.Wish
  alias Wl.Repo
  import Ecto.Query
  def process(nil), do: nil

  def process(id) do
    query =
      from w in Wish,
        where: w.id == ^id and is_nil(w.archived_at),
        preload: ^Wish.preload_list()

    Repo.one(query)
  end
end
