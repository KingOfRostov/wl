defmodule Wl.Accounts.Commands.CreateUser do
  alias Wl.Accounts.Entities.User
  alias Wl.Repo

  def process(attrs) do
    %User{}
    |> User.new_user_changeset(attrs)
    |> Repo.insert()
  end
end
