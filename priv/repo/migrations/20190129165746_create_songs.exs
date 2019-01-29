defmodule BirdsongQuizzer.Repo.Migrations.CreateSongs do
  use Ecto.Migration

  def change do
    create table(:songs) do
      add :genus, :string
      add :species, :string
      add :file_url, :string
      add :common_name, :string

      timestamps()
    end

  end
end
