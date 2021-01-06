defmodule Wl.Accounts.Auth do
  alias Argon2
  alias Wl.Accounts
  alias Wl.Accounts.Entities.User
  alias Wl.Accounts.Services.SessionStorage

  def create_session(user), do: SessionStorage.create_session(user)
  def check_token(user_id, token), do: SessionStorage.check_token(user_id, token)
  def drop_session(user_id), do: SessionStorage.drop_session(user_id)

  def authenticate(username, password) do
    username
    |> Accounts.get_user_by_username()
    |> check_pass(password)
  end

  def check_pass({:error, _}, _) do
    {:error, "wrong credentials"}
  end

  def check_pass(nil, _) do
    {:error, "wrong credentials"}
  end

  def check_pass(%User{} = user, password) do
    case Argon2.check_pass(user, password) do
      {:ok, user} -> {:ok, user}
      {:error, _} -> {:error, "wrong credentials"}
    end
  end
end
