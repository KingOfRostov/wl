defmodule Wl.Accounts.Commands.ChangeUserPassword do
  alias Wl.Accounts.Entities.User
  alias Wl.Repo

  def process(user, new_password, new_password_confirmation) do
    user
    |> User.change_password_changeset(%{
      password: new_password,
      password_confirmation: new_password_confirmation
    })
    |> Repo.update()
  end
end
