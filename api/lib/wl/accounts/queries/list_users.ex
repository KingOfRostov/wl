defmodule Wl.Accounts.Queries.ListUsers do
  alias Wl.Accounts.Entities.User
  alias Wl.Properties.Entities.Wish
  alias Wl.Accounts.Queries.Filters.UserFilter.Filter
  alias Wl.Repo
  import Ecto.Query

  def process(current_user_id, search_params) do
    ranking_query =
      from(w in Wish, as: :wish)
      |> where([{:wish, w}], is_nil(w.archived_at))
      |> select([{:wish, w}], %{id: w.id, row_number: row_number() |> over(:wishes_partition)})
      |> windows(wishes_partition: [partition_by: :user_id, order_by: :inserted_at])

    wish_subquery =
      from(w in Wish,
        join: r in subquery(ranking_query),
        on: w.id == r.id and r.row_number <= 3,
        where: is_nil(w.archived_at)
      )

    from(u in User, as: :user)
    |> where([{:user, u}], is_nil(u.archived_at))
    |> Filter.add_query(search_params)
    |> order_by([{:user, u}], [{:desc, u.id == ^current_user_id}, {:desc, u.inserted_at}])
    |> preload([{:user, u}], wishes: ^wish_subquery)
    |> Repo.paginate(search_params)
  end

  def process do
    from(u in User, as: :user)
    |> where([{:user, u}], is_nil(u.archived_at))
    |> order_by([{:user, u}], {:desc, u.inserted_at})
    |> Repo.all()
  end
end
