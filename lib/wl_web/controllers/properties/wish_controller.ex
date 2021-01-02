defmodule WlWeb.Properties.WishController do
  use WlWeb, :controller
  alias Wl.Properties

  def new(conn, _) do
    changeset = Properties.wish_changeset()
    render(conn, "new.html", %{changeset: changeset})
  end

  def create(conn, %{"wish" => wish_params}) do
    user_id = get_session(conn, :current_user_id)
    wish_params = Map.put(wish_params, "user_id", user_id)

    case Properties.create_wish(wish_params) do
      {:ok, wish} ->
        conn
        |> put_flash(:info, "Wish #{wish.name} has been created successfully!")
        |> redirect(to: Routes.wish_path(conn, :show, wish))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Oops, something went wrong! Please check the errors below.")
        |> put_status(422)
        |> render("new.html", %{changeset: changeset})
    end
  end

  def show(conn, %{"id" => id}) do
    wish = Properties.get_wish(id)
    render(conn, "show.html", %{wish: wish})
  end

  def edit(conn, %{"id" => id}) do
    wish = Properties.get_wish(id)
    changeset = Properties.wish_changeset(wish)
    render(conn, "edit.html", %{wish: wish, changeset: changeset})
  end

  def update(conn, %{"id" => id, "wish" => wish_params}) do
    wish = Properties.get_wish(id)

    case Properties.update_wish(wish, wish_params) do
      {:ok, wish} ->
        redirect(conn, to: Routes.wish_path(conn, :show, wish))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Oops, something went wrong! Please check the errors below.")
        |> put_status(422)
        |> render("edit.html", %{wish: wish, changeset: changeset})
    end
  end
end
