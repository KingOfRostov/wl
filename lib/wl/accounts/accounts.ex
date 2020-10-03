defmodule Wl.Accounts do
  alias Wl.Accounts.Commands.{
    ArchiveUser,
    ChangeUserPassword,
    CheckUserPassword,
    CreateUser,
    UpdateUser
  }

  alias Wl.Accounts.Queries.{GetUser, ListUsers}

  ### USER ###
  def archive_user(user), do: ArchiveUser.process(user)
  def update_user(user, params), do: UpdateUser.process(user, params)

  def change_user_password(user, new_password, new_password_confirmation),
    do: ChangeUserPassword.process(user, new_password, new_password_confirmation)

  def check_user_password(user, password), do: CheckUserPassword.process(user, password)

  def create_user(attrs), do: CreateUser.process(attrs)
  def get_user(id), do: GetUser.process(id)
  def list_users, do: ListUsers.process()
end
