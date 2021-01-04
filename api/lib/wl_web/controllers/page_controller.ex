defmodule WlWeb.PageController do
  use WlWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
