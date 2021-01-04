defmodule Wl.Accounts.Commands.UpdateUser do
  alias Wl.Accounts.Entities.User
  alias Wl.ImageUploader
  alias Wl.Repo

  def process(user, params) do
    update_changeset = User.changeset(user, params)

    case Repo.update(update_changeset) do
      {:ok, user} ->
        ImageUploader.delete_old_image(update_changeset, :profile_photo)
        {:ok, user}

      error ->
        error
    end
  end
end
