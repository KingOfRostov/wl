defmodule WlWeb.Accounts.UserController do
  use WlWeb, :controller
  alias Wl.Accounts
  alias Wl.Accounts.Auth

  def index(conn, _params) do
    current_user_id = get_session(conn, :current_user_id)
    users = Accounts.list_users(current_user_id)
    render(conn, "index.html", %{users: users})
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user(id)
    render(conn, "show.html", %{user: user})
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user(id)
    changeset = Accounts.user_changeset(user)
    render(conn, "edit.html", %{user: user, changeset: changeset})
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        redirect(conn, to: Routes.user_path(conn, :show, user))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Oops, something went wrong! Please check the errors below.")
        |> put_status(422)
        |> render("edit.html", %{user: user, changeset: changeset})
    end
  end

  def new(conn, _) do
    changeset = Accounts.user_changeset()
    render(conn, "new.html", %{changeset: changeset})
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        {:ok, access_token} = Auth.create_session(user)

        conn
        |> put_flash(:info, "Welcome #{user.username}!")
        |> put_session(:token, access_token)
        |> put_session(:current_user_id, user.id)
        |> put_session(:logged_in, true)
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Oops, something went wrong! Please check the errors below.")
        |> put_status(422)
        |> render("new.html", %{changeset: changeset})
    end
  end
end
