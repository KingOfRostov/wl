defmodule Wl.Accounts.RelationshipTest do
  use Wl.DataCase
  alias Wl.Accounts

  setup do
    user_john = insert(:user, name: "John")
    user_tony = insert(:user, name: "Tony")
    user_sarah = insert(:user, name: "Sarah")
    %{user_john: user_john, user_tony: user_tony, user_sarah: user_sarah}
  end

  test "follow/unfollow/list_followers/list_followed", %{
    user_john: user_john,
    user_tony: user_tony,
    user_sarah: user_sarah
  } do
    Accounts.follow(user_john.id, user_sarah.id)
    Accounts.follow(user_sarah.id, user_john.id)
    Accounts.follow(user_tony.id, user_sarah.id)
    Accounts.follow(user_tony.id, user_john.id)
    Accounts.unfollow(user_tony.id, user_john.id)
    # John followers
    john_followers_list = Accounts.list_user_followers(user_john.id)
    assert length(john_followers_list) == 1
    assert john_followers_list |> Enum.at(0) |> Map.get(:id) == user_sarah.id
    # John followed
    john_followers_list = Accounts.list_user_followed(user_john.id)
    assert length(john_followers_list) == 1
    assert john_followers_list |> Enum.at(0) |> Map.get(:id) == user_sarah.id
    # Sarah followers
    sarah_followers_list = Accounts.list_user_followers(user_sarah.id)
    assert length(sarah_followers_list) == 2

    assert Enum.all?(
             sarah_followers_list,
             &(&1.id in [user_john.id, user_tony.id])
           )

    # Sarah followed
    sarah_followers_list = Accounts.list_user_followed(user_sarah.id)
    assert length(sarah_followers_list) == 1
    assert sarah_followers_list |> Enum.at(0) |> Map.get(:id) == user_john.id
    # Tony followers
    tony_followers_list = Accounts.list_user_followers(user_tony.id)
    assert Enum.empty?(tony_followers_list)

    # Tony followed
    tony_followers_list = Accounts.list_user_followed(user_tony.id)
    assert length(tony_followers_list) == 1
    assert tony_followers_list |> Enum.at(0) |> Map.get(:id) == user_sarah.id
  end
end
