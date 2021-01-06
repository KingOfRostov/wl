defmodule WlWeb.Accounts.UserView do
  use WlWeb, :view

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      name: user.name,
      surname: user.surname,
      followers_number: user.followers_number,
      followed_number: user.followed_number,
      wishes_number: user.wishes_number
    }
  end
end
