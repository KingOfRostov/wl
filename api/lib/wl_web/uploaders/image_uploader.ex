defmodule Wl.ImageUploader do
  use Arc.Definition
  use Arc.Ecto.Definition
  import Ecto.Changeset, only: [get_change: 2]
  alias Ecto.UUID

  @extension_whitelist ~w(.jpg .jpeg .png)

  @versions [:original, :tiny, :avatar]

  # Whitelist file extensions:
  def validate({file, _}) do
    Enum.member?(@extension_whitelist, file_extension(file))
  end

  # Define a thumbnail transformation:
  # def transform(:small, _) do
  #   {:convert, "-auto-orient -strip -thumbnail 500x500\>"}
  # end

  def transform(:avatar, _) do
    {:convert, "-auto-orient -strip -thumbnail 200x200\>"}
  end

  def transform(:tiny, _) do
    {:convert, "-auto-orient -strip -thumbnail 100x100\>"}
  end

  def file_extension(file), do: file.file_name |> Path.extname() |> String.downcase()
  def __storage, do: Arc.Storage.Local

  # Override the persisted filenames:
  def filename(version, {file, _scope}) do
    "#{file.file_name}_#{version}"
  end

  # Override the storage directory:
  def storage_dir(version, {file, scope}) do
    "uploads/users/images/"
  end

  # Generate unique name for files
  def with_files(attrs, keys) do
    keys
    |> Enum.reduce(attrs, fn key, attrs_acc ->
      with_file(attrs_acc, key, attrs[key])
    end)
  end

  def with_file(attrs, _key, nil) do
    attrs
  end

  def with_file(attrs, key, "") do
    %{attrs | key => nil}
  end

  def with_file(attrs, key, attr) do
    attrs |> Map.put(key, generate_filename(attr))
  end

  def generate_filename(attrs) do
    filename = upload_file(attrs)
    file_extension = filename |> Path.extname() |> String.downcase()
    uniq_filename = "image_" <> UUID.generate() <> file_extension
    %{attrs | filename: uniq_filename}
  end

  def upload_file(%Plug.Upload{filename: filename}), do: filename

  def delete_old_image(changeset, field_name) do
    old_photo = Map.get(changeset.data, field_name)

    new_photo = get_change(changeset, field_name)

    if !is_nil(new_photo) and !is_nil(old_photo) do
      delete(old_photo.file_name)
      changeset
    else
      changeset
    end
  end
end
