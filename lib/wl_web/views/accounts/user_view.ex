defmodule WlWeb.Accounts.UserView do
  use WlWeb, :view

  def get_previous_page_class(page_number, total_pages)
      when page_number <= total_pages and page_number > 1,
      do: "page-item"

  def get_previous_page_class(_, _), do: "page-item disabled"

  def get_next_page_class(page_number, total_pages)
      when page_number < total_pages,
      do: "page-item"

  def get_next_page_class(_, _), do: "page-item disabled"
end
