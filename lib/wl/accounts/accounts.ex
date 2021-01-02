defmodule Wl.Accounts do
  alias Wl.Accounts.Entities.User

  alias Wl.Accounts.Commands.{
    ArchiveRelationship,
    ArchiveUser,
    ChangeUserPassword,
    CheckUserPassword,
    CreateRelationship,
    CreateUser,
    UpdateUser
  }

  alias Wl.Accounts.Queries.{
    GetUser,
    GetUserByUsername,
    GetUserChangeset,
    IsFollowing,
    ListUserFollowed,
    ListUserFollowers,
    ListUsers
  }

  ### USER ###
  def archive_user(user), do: ArchiveUser.process(user)
  def update_user(user, params), do: UpdateUser.process(user, params)

  def user_changeset, do: GetUserChangeset.process()
  def user_changeset(user), do: GetUserChangeset.process(user)

  def change_user_password(user, new_password, new_password_confirmation),
    do: ChangeUserPassword.process(user, new_password, new_password_confirmation)

  def check_user_password(user, password), do: CheckUserPassword.process(user, password)

  def create_user(attrs), do: CreateUser.process(attrs)
  def get_user(id), do: GetUser.process(id)
  def get_user_by_username(username), do: GetUserByUsername.process(username)
  def list_users, do: ListUsers.process()

  def list_users(current_user_id, search_params),
    do: ListUsers.process(current_user_id, search_params)

  ### RELATIONSHIP ###
  def is_following?(follower_user_id, followed_user_id),
    do: IsFollowing.process(follower_user_id, followed_user_id)

  def follow(%User{id: follower_user_id}, %User{id: followed_user_id}),
    do:
      create_relationship(%{
        follower_user_id: follower_user_id,
        followed_user_id: followed_user_id
      })

  def follow(follower_user_id, followed_user_id),
    do:
      create_relationship(%{
        follower_user_id: follower_user_id,
        followed_user_id: followed_user_id
      })

  def unfollow(%User{id: follower_user_id}, %User{id: followed_user_id}),
    do:
      archive_relationship(%{
        follower_user_id: follower_user_id,
        followed_user_id: followed_user_id
      })

  def unfollow(follower_user_id, followed_user_id),
    do:
      archive_relationship(%{
        follower_user_id: follower_user_id,
        followed_user_id: followed_user_id
      })

  def list_user_followers(user_id), do: ListUserFollowers.process(user_id)
  def list_user_followed(user_id), do: ListUserFollowed.process(user_id)
  def create_relationship(attrs), do: CreateRelationship.process(attrs)
  def archive_relationship(attrs), do: ArchiveRelationship.process(attrs)
end
