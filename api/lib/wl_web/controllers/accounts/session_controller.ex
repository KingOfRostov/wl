defmodule WlWeb.Accounts.SessionController do
  use WlWeb, :controller
  alias Wl.Accounts.Auth

  def create(conn, %{"username" => username, "password" => password}) do
    case Auth.authenticate(username, password) do
      {:ok, user} ->
        {:ok, access_token} = Auth.create_session(user)

        conn
        |> put_flash(:info, "Welcome back #{user.username}!")
        |> put_session(:token, access_token)
        |> put_session(:current_user_id, user.id)
        |> put_session(:logged_in, true)
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, message} ->
        conn
        |> put_status(401)
        |> put_flash(:error, message)
        |> render("new.html")
    end
  end

  def new(conn, _) do
    render(conn, "new.html")
  end

  def delete(conn, _) do
    user_id = get_session(conn, :current_user_id)
    Auth.drop_session(user_id)

    conn
    |> delete_session(:token)
    |> delete_session(:current_user_id)
    |> delete_session(:logged_in)
    |> put_flash(:info, "Logged out successfully")
    |> redirect(to: Routes.session_path(conn, :new))
  end
end
