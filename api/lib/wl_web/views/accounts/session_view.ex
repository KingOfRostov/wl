defmodule WlWeb.Accounts.SessionView do
  use WlWeb, :view
  alias WlWeb.Accounts.UserView

  def render("create.json", %{
        user: user,
        token: token,
        logged_in: logged_in
      }) do
    %{
      user: render_one(user, UserView, "user.json"),
      token: token,
      logged_in: logged_in
    }
  end

  def render("error.json", %{reason: reason}) do
    %{error: reason}
  end
end
