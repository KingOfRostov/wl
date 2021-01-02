defmodule Wl.Properties.WishTest do
  use Wl.DataCase
  alias Wl.Properties

  @create_valid_attrs %{
    name: "test wish",
    description: "test description"
  }

  @create_invalid_attrs %{
    name: nil,
    description: "test description"
  }

  @update_valid_attrs %{
    name: "new test wish",
    description: "new test description"
  }
  setup do
    user = insert(:user)
    %{user: user}
  end

  describe "create wish" do
    test "success creation", %{user: user} do
      {:ok, wish} = @create_valid_attrs |> Map.put(:user_id, user.id) |> Properties.create_wish()
      assert wish.user_id == user.id
    end

    test "failed creation", %{user: user} do
      {:error, changeset} =
        @create_invalid_attrs |> Map.put(:user_id, user.id) |> Properties.create_wish()

      assert changeset.errors == [name: {"can't be blank", [validation: :required]}]
    end
  end

  describe "update wish" do
    test "update", %{user: user} do
      {:ok, wish} = @create_valid_attrs |> Map.put(:user_id, user.id) |> Properties.create_wish()
      assert wish.user_id == user.id
      refute wish.name == @update_valid_attrs.name
      {:ok, updated_wish} = Properties.update_wish(wish, @update_valid_attrs)
      assert updated_wish.name == @update_valid_attrs.name
    end
  end

  describe "archive wish" do
    test "archive", %{user: user} do
      {:ok, wish} = @create_valid_attrs |> Map.put(:user_id, user.id) |> Properties.create_wish()
      assert wish.user_id == user.id
      refute wish.archived_at
      {:ok, archived_wish} = Properties.archive_wish(wish)
      assert archived_wish.archived_at
    end
  end
end
