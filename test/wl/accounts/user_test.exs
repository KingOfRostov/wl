defmodule Wl.Accounts.UserTest do
  use Wl.DataCase
  alias Wl.Accounts

  @create_valid_attrs %{
    name: "test name",
    surname: "test surname",
    username: "test username",
    password: "test_pass",
    password_confirmation: "test_pass"
  }

  @update_valid_attrs %{
    name: "new test name",
    surname: "new test surname",
    username: "new test username"
  }

  describe "user creation" do
    test "create a new user" do
      {:ok, user} = Accounts.create_user(@create_valid_attrs)

      assert user.name == @create_valid_attrs.name
      assert user.surname == @create_valid_attrs.surname
      assert user.username == @create_valid_attrs.username
      {:ok, _} = Argon2.check_pass(user, @create_valid_attrs.password)
    end

    test "error when creating a user with existing username" do
      {:ok, _existing_user} = Accounts.create_user(@create_valid_attrs)

      {:error, changeset} = Accounts.create_user(@create_valid_attrs)

      assert changeset.errors == [
               username:
                 {"has already been taken",
                  [constraint: :unique, constraint_name: "users_username_index"]}
             ]
    end

    test "error when creating a user with wrong password confirmation" do
      {:error, changeset} =
        @create_valid_attrs
        |> Map.put(:password_confirmation, "test_wrong_password")
        |> Accounts.create_user()

      assert changeset.errors == [
               password_confirmation: {"The password is not equal to password confirmation", []}
             ]
    end

    test "error when creating a user with short password" do
      {:error, changeset} =
        @create_valid_attrs
        |> Map.merge(%{password: "short", password_confirmation: "short"})
        |> Accounts.create_user()

      assert changeset.errors == [password: {"The password is too short", []}]
    end
  end

  describe "archive user" do
    test "archive user" do
      {:ok, user} = Accounts.create_user(@create_valid_attrs)
      assert is_nil(user.archived_at)
      {:ok, archived_user} = Accounts.archive_user(user)
      refute is_nil(archived_user.archived_at)

      # Wl.Accounts.get_user/1 shouldn't return archived users (for safety)
      assert user.id |> Accounts.get_user() |> is_nil()
    end
  end

  describe "update user" do
    test "update user" do
      {:ok, user} = Accounts.create_user(@create_valid_attrs)
      {:ok, updated_user} = Accounts.update_user(user, @update_valid_attrs)

      assert updated_user.name == @update_valid_attrs.name
      assert updated_user.surname == @update_valid_attrs.surname
      assert updated_user.username == @update_valid_attrs.username
    end

    test "error when trying to update user with invalid params" do
      {:ok, existing_user} = Accounts.create_user(@create_valid_attrs)

      {:ok, user} =
        @create_valid_attrs |> Map.put(:username, "new test username") |> Accounts.create_user()

      wrong_update_attrs = Map.put(@update_valid_attrs, :username, existing_user.username)
      {:error, changeset} = Accounts.update_user(user, wrong_update_attrs)

      assert changeset.errors == [
               username:
                 {"has already been taken",
                  [constraint: :unique, constraint_name: "users_username_index"]}
             ]
    end
  end

  describe "change user password" do
    test "change password" do
      {:ok, user} = Accounts.create_user(@create_valid_attrs)

      {:ok, updated_user} =
        Accounts.change_user_password(user, "new_test_password", "new_test_password")

      {:ok, _} = Accounts.check_user_password(updated_user, "new_test_password")
    end

    test "error when trying to change user password to invalid" do
      {:ok, user} = Accounts.create_user(@create_valid_attrs)

      {:error, changeset} = Accounts.change_user_password(user, "short", "short")

      assert changeset.errors == [password: {"The password is too short", []}]
    end

    test "error when trying to change user password with wrong confirmation" do
      {:ok, user} = Accounts.create_user(@create_valid_attrs)

      {:error, changeset} =
        Accounts.change_user_password(user, "new_test_password", "new_password")

      assert changeset.errors == [
               password_confirmation: {"The password is not equal to password confirmation", []}
             ]
    end
  end
end
