defmodule Wl.Accounts.Queries.ListUsers do
  alias Wl.Accounts.Entities.User
  alias Wl.Accounts.Queries.Filters.UserFilter.Filter
  alias Wl.Repo
  import Ecto.Query

  def process(current_user_id, search_params) do
    from(u in User, as: :user)
    |> where([{:user, u}], is_nil(u.archived_at))
    |> Filter.add_query(search_params)
    |> order_by([{:user, u}], [{:desc, u.id == ^current_user_id}, {:asc, u.inserted_at}])
    |> Repo.paginate(search_params)
  end

  def process do
    from(u in User, as: :user)
    |> where([{:user, u}], is_nil(u.archived_at))
    |> order_by([{:user, u}], {:asc, u.inserted_at})
    |> Repo.all()
  end
end
