defmodule Wl.Accounts.Queries.GetUserChangeset do
  alias Wl.Accounts.Entities.User

  def process(user), do: User.changeset(user, %{})
end
