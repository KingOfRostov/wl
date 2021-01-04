defmodule Wl.Properties.Queries.Filters.WishFilter.Filter do
  alias Wl.Properties.Queries.Filters.WishFilter.{Search, User}
  import Ecto.Query

  def add_query(query, %{search: search, user_id: user_id}) do
    query
    |> join(:inner, [{:wish, w}], u in assoc(w, :user), as: :user)
    |> Search.add_query(search)
    |> User.add_query(user_id)
  end
end
