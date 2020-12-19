defmodule WlWeb.PageControllerTest do
  use WlWeb.ConnCase

  @valid_user_params %{
    name: "Test Name",
    surname: "Test Surname",
    username: "Test Username",
    password: "testpassword",
    password_confirmation: "testpassword"
  }

  @invalid_user_params %{
    name: "Test Name",
    surname: "Test Surname",
    username: "",
    password: "testpassword",
    password_confirmation: "testpassword"
  }

  describe "index/1" do
    test "list all users | GET /users", %{conn: conn} do
      user_john = insert(:user, name: "John")
      user_tony = insert(:user, name: "Tony")
      conn = get(conn, Routes.user_path(conn, :index))
      assert html_response(conn, 200) =~ user_john.username
      assert html_response(conn, 200) =~ user_tony.username
    end
  end

  describe "show/2" do
    test "show user | GET /user/:id", %{conn: conn} do
      user_john = insert(:user, name: "John")
      conn = get(conn, Routes.user_path(conn, :show, user_john))
      assert html_response(conn, 200) =~ user_john.username
    end
  end

  describe "create/2" do
    test "create user with valid params | POST /users", %{conn: conn} do
      create_conn = post(conn, Routes.user_path(conn, :create), %{"user" => @valid_user_params})
      assert html_response(create_conn, 302)
      index_conn = get(conn, Routes.user_path(conn, :index))
      assert html_response(index_conn, 200) =~ @valid_user_params.username
    end

    test "create user with invalid params | POST /users", %{conn: conn} do
      create_conn = post(conn, Routes.user_path(conn, :create), %{"user" => @invalid_user_params})
      assert html_response(create_conn, 422)
      index_conn = get(conn, Routes.user_path(conn, :index))
      refute html_response(index_conn, 200) =~ @valid_user_params.username
    end
  end

  describe "new/1" do
    test "new user | GET /users/new", %{conn: conn} do
      edit_conn = get(conn, Routes.user_path(conn, :new))
      assert html_response(edit_conn, 200)
    end
  end

  describe "update/2" do
    test "update user with valid params | PUT /users/:id", %{conn: conn} do
      user_john = insert(:user, name: "John")

      show_john_name_conn = get(conn, Routes.user_path(conn, :show, user_john))
      assert html_response(show_john_name_conn, 200) =~ "John"

      update_conn =
        put(conn, Routes.user_path(conn, :update, user_john), %{"user" => %{name: "Tony"}})

      assert html_response(update_conn, 302)
      show_tony_name_conn = get(conn, Routes.user_path(conn, :show, user_john))
      assert html_response(show_tony_name_conn, 200) =~ "Tony"
    end

    test "update user with invalid params | PUT /users/:id", %{conn: conn} do
      user_john = insert(:user, name: "John")

      show_john_name_conn = get(conn, Routes.user_path(conn, :show, user_john))
      assert html_response(show_john_name_conn, 200) =~ "John"

      update_conn =
        put(conn, Routes.user_path(conn, :update, user_john), %{
          "user" => %{username: "", name: "Tony"}
        })

      assert html_response(update_conn, 422)
      show_tony_name_conn = get(conn, Routes.user_path(conn, :show, user_john))
      refute html_response(show_tony_name_conn, 200) =~ "Tony"
    end
  end

  describe "edit/2" do
    test "edit user | GET /users/:id/edit", %{conn: conn} do
      user_john = insert(:user, name: "John")
      edit_conn = get(conn, Routes.user_path(conn, :edit, user_john))
      assert html_response(edit_conn, 200)
    end
  end
end
