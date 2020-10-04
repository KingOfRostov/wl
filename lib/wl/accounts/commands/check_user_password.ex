defmodule Wl.Accounts.Commands.CheckUserPassword do
  alias Wl.Accounts.Entities.User

  def process(%User{} = user, password) do
    Argon2.check_pass(user, password)
  end

  def process(_, _), do: {:error, "user not found"}
end
