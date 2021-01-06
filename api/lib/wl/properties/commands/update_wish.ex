defmodule Wl.Properties.Commands.UpdateWish do
  alias Wl.Properties.Entities.Wish
  alias Wl.ImageUploader
  alias Wl.Repo

  def process(wish, params) do
    update_changeset = Wish.changeset(wish, params)

    case Repo.update(update_changeset) do
      {:ok, wish} ->
        ImageUploader.delete_old_image(update_changeset, :image)
        {:ok, wish}

      error ->
        error
    end
  end
end
