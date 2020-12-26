defmodule Wl.Accounts.Commands.CreateRelationship do
  alias Wl.Accounts.Entities.Relationship
  alias Wl.Repo

  def process(attrs) do
    %Relationship{}
    |> Relationship.new_relationship_changeset(attrs)
    |> Repo.insert()
  end
end
