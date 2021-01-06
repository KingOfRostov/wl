defmodule WlWeb.Accounts.SessionView do
  use WlWeb, :view

  def render("create.json", %{
        token: token,
        current_user_id: current_user_id,
        logged_in: logged_in
      }) do
    %{token: token, current_user_id: current_user_id, logged_in: logged_in}
  end

  def render("error.json", %{reason: reason}) do
    %{error: reason}
  end
end
