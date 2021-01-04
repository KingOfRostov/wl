defmodule Wl.Properties do
  alias Wl.Properties.Commands.{ArchiveWish, CreateWish, UpdateWish}
  alias Wl.Properties.Queries.{GetWish, GetWishChangeset, ListWishes}
  # WISHES
  def wish_changeset, do: GetWishChangeset.process()
  def wish_changeset(wish), do: GetWishChangeset.process(wish)
  def create_wish(params), do: CreateWish.process(params)
  def update_wish(wish, params), do: UpdateWish.process(wish, params)
  def archive_wish(wish), do: ArchiveWish.process(wish)
  def get_wish(id), do: GetWish.process(id)
  def list_wishes(search_params), do: ListWishes.process(search_params)
end
