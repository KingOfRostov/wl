defmodule Wl.Properties.Commands.CreateWish do
  alias Wl.Properties.Entities.Wish
  alias Wl.Repo

  def process(attrs) do
    %Wish{}
    |> Wish.changeset(attrs)
    |> Repo.insert()
  end
end
