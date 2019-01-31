defmodule BirdsongQuizzerWeb.QuizController do
  use BirdsongQuizzerWeb, :controller

  alias BirdsongQuizzer.Quizzes
  alias BirdsongQuizzer.Quizzes.Quiz

  action_fallback BirdsongQuizzerWeb.FallbackController

  def index(conn, _params) do
    questions = BirdsongQuizzer.QuizFormulator.perform()
    render(conn, "index.json", questions: questions)
  end

  def create(conn, %{"quiz" => quiz_params}) do
    with {:ok, %Quiz{} = quiz} <- Quizzes.create_quiz(quiz_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.quiz_path(conn, :show, quiz))
      |> render("show.json", quiz: quiz)
    end
  end

  def show(conn, %{"id" => id}) do
    quiz = Quizzes.get_quiz!(id)
    render(conn, "show.json", quiz: quiz)
  end

  def update(conn, %{"id" => id, "quiz" => quiz_params}) do
    quiz = Quizzes.get_quiz!(id)

    with {:ok, %Quiz{} = quiz} <- Quizzes.update_quiz(quiz, quiz_params) do
      render(conn, "show.json", quiz: quiz)
    end
  end

  def delete(conn, %{"id" => id}) do
    quiz = Quizzes.get_quiz!(id)

    with {:ok, %Quiz{}} <- Quizzes.delete_quiz(quiz) do
      send_resp(conn, :no_content, "")
    end
  end
end
