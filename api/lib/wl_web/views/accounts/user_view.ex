defmodule WlWeb.Accounts.UserView do
  use WlWeb, :view
  alias Wl.ImageUploader
  alias __MODULE__

  def render("index.json", %{users: users}) do
    %{
      users: render_many(users.entries, UserView, "user.json"),
      page_number: users.page_number,
      total_entries: users.total_entries,
      total_pages: users.total_pages
    }
  end

  def render("show.json", %{user: user}) do
    render_one(user, UserView, "user.json")
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      name: user.name,
      surname: user.surname,
      followers_number: user.followers_number,
      followed_number: user.followed_number,
      wishes_number: user.wishes_number,
      profile_photo_path: ImageUploader.full_url(user.profile_photo, :avatar)
    }
  end
end
