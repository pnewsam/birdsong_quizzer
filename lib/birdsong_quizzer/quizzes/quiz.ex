defmodule BirdsongQuizzer.Quizzes.Quiz do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :answers, {:array, :map}
    field :song_url, :string

    timestamps()
  end

  @doc false
  def changeset(quiz, attrs) do
    quiz
    |> cast(attrs, [:answers, :song_url])
    |> validate_required([:answers, :song_url])
  end
end
