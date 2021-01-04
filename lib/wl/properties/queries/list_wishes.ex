defmodule Wl.Properties.Queries.ListWishes do
  alias Wl.Properties.Entities.Wish
  alias Wl.Properties.Queries.Filters.WishFilter.Filter
  alias Wl.Repo
  import Ecto.Query

  def process(search_params) do
    from(w in Wish, as: :wish)
    |> where([{:wish, w}], is_nil(w.archived_at))
    |> Filter.add_query(search_params)
    |> order_by([{:wish, w}], {:asc, w.inserted_at})
    |> preload(^Wish.preload_list())
    |> Repo.paginate(search_params)
  end
end
