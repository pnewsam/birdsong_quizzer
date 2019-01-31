defmodule BirdsongQuizzerWeb.QuizView do
  use BirdsongQuizzerWeb, :view
  alias BirdsongQuizzerWeb.QuizView

  def render("index.json", %{questions: questions}) do
    %{data: render_many(questions, QuizView, "quiz.json")}
  end

  def render("show.json", %{quiz: quiz}) do
    %{data: render_one(quiz, QuizView, "quiz.json")}
  end

  def render("quiz.json", %{quiz: quiz}) do
    %{id: quiz.id, answers: quiz.answers, songUrl: quiz.songUrl, id: quiz.id}
  end
end
