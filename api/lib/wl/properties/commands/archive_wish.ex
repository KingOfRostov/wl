defmodule Wl.Properties.Commands.ArchiveWish do
  alias Wl.Accounts.Entities.User
  alias Wl.Properties.Entities.Wish
  alias Wl.Repo
  import Ecto.Query

  def process(wish) do
    transaction =
      Repo.transaction(fn ->
        res =
          wish
          |> Wish.changeset(%{archived_at: NaiveDateTime.utc_now()})
          |> Repo.update()

        wish_user_query = from u in User, where: is_nil(u.archived_at) and u.id == ^wish.user_id
        Repo.update_all(wish_user_query, inc: [wishes_number: -1])
        res
      end)

    case transaction do
      {:ok, res} -> res
      error -> error
    end
  end
end
