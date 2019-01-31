defmodule BirdsongQuizzer.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :answers, {:array, :map}
      add :song_url, :string
      add :id, :string

      timestamps()
    end

  end
end
