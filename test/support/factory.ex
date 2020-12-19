defmodule Wl.Factories.Factory do
  use ExMachina.Ecto, repo: Wl.Repo
  alias Faker.{Internet, Person}
  alias Wl.Accounts.Entities.User

  def user_factory do
    %User{
      name: Person.first_name(),
      surname: Person.last_name(),
      username: Internet.user_name()
    }
  end
end
