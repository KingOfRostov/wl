defmodule Wl.Accounts.Services.UserAuthPlug do
  use WlWeb, :controller
  alias Wl.Accounts.Auth
  def init(_opts), do: nil

  def call(conn, _opts) do
    token = get_session(conn, :token)
    current_user_id = get_session(conn, :current_user_id)

    case Auth.check_token(current_user_id, token) do
      :ok ->
        conn

      _ ->
        conn
        |> put_flash(:error, "You need to be signed in to access that page.")
        |> redirect(to: Routes.session_path(conn, :new))
        |> halt()
    end
  end
end
