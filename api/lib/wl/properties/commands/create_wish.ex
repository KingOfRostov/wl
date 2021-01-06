defmodule Wl.Properties.Commands.CreateWish do
  alias Wl.Accounts.Entities.User
  alias Wl.Properties.Entities.Wish
  alias Wl.Repo
  import Ecto.Query

  def process(attrs) do
    transaction =
      Repo.transaction(fn ->
        res =
          %Wish{}
          |> Wish.changeset(attrs)
          |> Repo.insert()

        user_id = attrs["user_id"] || attrs[:user_id]

        wish_user_query = from u in User, where: is_nil(u.archived_at) and u.id == ^user_id

        Repo.update_all(wish_user_query, inc: [wishes_number: 1])
        res
      end)

    case transaction do
      {:ok, res} -> res
      error -> error
    end
  end
end
