defmodule Wl.Properties.Queries.GetWishChangeset do
  alias Wl.Properties.Entities.Wish

  def process, do: Wish.changeset(%Wish{}, %{})
  def process(wish), do: Wish.changeset(wish, %{})
end
