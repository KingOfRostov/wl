defmodule Wl.Properties.Queries.Filters.WishFilter.User do
  import Ecto.Query
  def add_query(query, nil), do: query

  def add_query(query, user_id) do
    query
    |> where(
      [{:user, u}],
      u.id == ^user_id
    )
  end
end
