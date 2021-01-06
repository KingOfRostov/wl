defmodule WlWeb.Accounts.RelationshipView do
  use WlWeb, :view
  alias Wl.Accounts

  def get_follow_unfollow_button_text(conn, follower_user_id, followed_user_id) do
    if Accounts.is_following?(follower_user_id, followed_user_id) do
      %{
        button_text: "Unfollow",
        action:
          Routes.user_path(conn, :unfollow, follower_user_id, %{
            followed_user_id: followed_user_id
          }),
        button_color_class: "btn-outline-warning"
      }
    else
      %{
        button_text: "Follow",
        action:
          Routes.user_path(conn, :follow, follower_user_id, %{
            followed_user_id: followed_user_id
          }),
        button_color_class: "btn-outline-primary"
      }
    end
  end
end
