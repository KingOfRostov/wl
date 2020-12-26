defmodule Wl.Accounts.Queries.Filters.UserFilter.Filter do
  alias Wl.Accounts.Queries.Filters.UserFilter.Search

  def add_query(query, %{search: search}) do
    query
    |> Search.add_query(search)
  end

  def add_query(query, _), do: query
end
