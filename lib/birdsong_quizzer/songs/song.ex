defmodule BirdsongQuizzer.Songs.Song do
  use Ecto.Schema
  import Ecto.Changeset


  schema "songs" do
    field :common_name, :string
    field :file_url, :string
    field :genus, :string
    field :species, :string

    timestamps()
  end

  @doc false
  def changeset(song, attrs) do
    song
    |> cast(attrs, [:genus, :species, :file_url, :common_name])
    |> validate_required([:genus, :species, :file_url, :common_name])
  end
end
