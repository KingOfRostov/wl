defmodule Wl.Properties do
  alias Wl.Properties.Commands.{CreateWish, UpdateWish}
  # WISHES
  def create_wish(params), do: CreateWish.process(params)
  def update_wish(wish, params), do: UpdateWish.process(wish, params)
end
