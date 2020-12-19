defmodule WlWeb.Accounts.UserController do
  use WlWeb, :controller
  alias Wl.Accounts

  def index(conn, _params) do
    users = Accounts.list_users()
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
        |> render("edit.html", %{user: user, changeset: changeset})
    end
  end
end
