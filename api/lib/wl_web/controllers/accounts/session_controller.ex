defmodule WlWeb.Accounts.SessionController do
  use WlWeb, :controller
  alias Wl.Accounts
  alias Wl.Accounts.Auth

  def create(conn, %{"username" => username, "password" => password}) do
    case Auth.authenticate(username, password) do
      {:ok, user} ->
        {:ok, access_token} = Auth.create_session(user)

        conn
        |> render("create.json", %{
          user: user,
          token: access_token,
          logged_in: true
        })

      {:error, reason} ->
        conn
        |> put_status(401)
        |> render("error.json", %{reason: reason})
    end
  end

  def check(conn, %{"token" => token}) do
    case Auth.get_user_id_by_token(token) do
      nil ->
        conn
        |> put_status(401)
        |> render("error.json", %{reason: "Not authorized"})

      user_id ->
        user = Accounts.get_user(user_id)

        conn
        |> render("show.json", %{
          user: user,
          token: token,
          logged_in: true
        })
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
