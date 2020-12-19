defmodule Wl.Accounts.Entities.User do
  use Ecto.Schema

  import Ecto.Changeset
  alias Ecto.Changeset

  @preload_list []
  @required [:name, :surname, :username]
  @optional [:archived_at, :profile_photo]
  @password_fields [:password, :password_confirmation]
  schema "users" do
    field :name, :string
    field :surname, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string
    field :profile_photo, :string
    field :archived_at, :naive_datetime
    timestamps()
  end

  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, @optional ++ @required)
    |> validate_required(@required)
    |> validate_length(:username, min: 3, max: 18)
    |> unique_constraint(:username)
  end

  def new_user_changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, @optional ++ @required ++ @password_fields)
    |> validate_required(@required ++ @password_fields)
    |> unique_constraint(:username)
    |> validate_password(:password)
    |> validate_password_confirmation(:password, :password_confirmation)
    |> put_password_hash
  end

  def change_password_changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, @password_fields)
    |> validate_required(@password_fields)
    |> validate_password(:password)
    |> validate_password_confirmation(:password, :password_confirmation)
    |> put_password_hash
  end

  def preload_list, do: @preload_list

  defp validate_password(changeset, field, options \\ []) do
    changeset
    |> validate_change(field, fn _, password ->
      case strong_password?(password) do
        {:ok, _} -> []
        {:error, msg} -> [{field, options[:message] || msg}]
      end
    end)
  end

  defp strong_password?(password) when byte_size(password) > 7 do
    {:ok, password}
  end

  defp strong_password?(_), do: {:error, "The password is too short"}

  defp validate_password_confirmation(changeset, pass_field, conf_field, options \\ []) do
    pwd = get_change(changeset, pass_field)

    validate_change(changeset, conf_field, fn _, password_confirmation ->
      case password_confirmation do
        ^pwd ->
          []

        _ ->
          [
            password_confirmation: options[:message] || "Wrong password confirmation"
          ]
      end
    end)
  end

  defp put_password_hash(
         %Changeset{
           valid?: true,
           changes: %{password: password, password_confirmation: _password_confirmation}
         } = changeset
       ) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
