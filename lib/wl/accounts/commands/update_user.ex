defmodule Wl.Accounts.Commands.UpdateUser do
  alias Wl.Accounts.Entities.User
  alias Wl.Repo
  alias Wl.ImageUploader
  import Ecto.Changeset, only: [get_change: 2]

  def process(user, params) do
    update_changeset = User.changeset(user, params)

    case Repo.update(update_changeset) do
      {:ok, user} ->
        delete_old_profile_photo(update_changeset)
        {:ok, user}

      error ->
        error
    end
  end

  defp delete_old_profile_photo(changeset) do
    old_photo = changeset.data.profile_photo
    new_photo = get_change(changeset, :profile_photo)

    if !is_nil(new_photo) and !is_nil(old_photo) do
      ImageUploader.delete(old_photo.file_name)
      changeset
    else
      changeset
    end
  end
end
