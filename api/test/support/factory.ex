defmodule Wl.Factories.Factory do
  use ExMachina.Ecto, repo: Wl.Repo
  alias Faker.{Internet, Person, String}
  alias Wl.Properties.Entities.Wish
  alias Wl.Accounts.Entities.User

  def user_factory do
    %User{
      name: Person.first_name(),
      surname: Person.last_name(),
      username: Internet.user_name()
    }
  end

  def wish_factory do
    %Wish{
      name: String.base64(8),
      description: String.base64(24)
    }
  end
end
