defmodule Wl.Properties.Queries.Filters.WishFilter.Search do
  import Ecto.Query
  def add_query(query, nil), do: query

  def add_query(query, search) do
    words =
      search
      |> String.trim()
      |> String.split()

    Enum.reduce(words, query, fn search_word, acc_query -> find_word(acc_query, search_word) end)
  end

  defp find_word(query, word) do
    ilike_word_value = "%#{word}%"

    query
    |> where(
      [{:wish, w}, {:user, u}],
      ilike(w.description, ^ilike_word_value) or ilike(w.name, ^ilike_word_value) or
        ilike(u.username, ^ilike_word_value) or ilike(u.name, ^ilike_word_value) or
        ilike(u.surname, ^ilike_word_value)
    )
  end
end
