defmodule WlWeb.Properties.WishController do
  use WlWeb, :controller
  use Params
  alias Wl.Properties

  defparams(
    wish_search(%{
      search: [field: :string, default: nil],
      user_id: [field: :integer, default: nil],
      page!: [field: :integer, default: 1],
      page_size!: [field: :integer, default: 5]
    })
  )

  def index(conn, params) do
    changeset = wish_search(params)
    search_params = Params.to_map(changeset)

    wishes = Properties.list_wishes(search_params)
    render(conn, "index.html", %{wishes: wishes})
  end

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
    user_id = get_session(conn, :current_user_id)
    wish = Properties.get_wish(id)

    case wish do
      nil ->
        conn
        |> put_flash(:error, "Not found.")
        |> redirect(to: Routes.user_path(conn, :show, user_id))

      wish ->
        render(conn, "show.html", %{wish: wish})
    end
  end

  def edit(conn, %{"id" => id}) do
    user_id = get_session(conn, :current_user_id)
    wish = Properties.get_wish(id)

    case wish do
      nil ->
        conn
        |> put_flash(:error, "Not found.")
        |> redirect(to: Routes.user_path(conn, :show, user_id))

      wish ->
        changeset = Properties.wish_changeset(wish)
        render(conn, "edit.html", %{wish: wish, changeset: changeset})
    end
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

  def archive(conn, %{"id" => id}) do
    wish = Properties.get_wish(id)

    case Properties.archive_wish(wish) do
      {:ok, wish} ->
        redirect(conn, to: Routes.user_path(conn, :show, wish.user_id))

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Already archived.")
        |> put_status(422)
        |> render("show.html", %{wish: wish})
    end
  end
end
