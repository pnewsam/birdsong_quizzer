defmodule BirdsongQuizzerWeb.QuizControllerTest do
  use BirdsongQuizzerWeb.ConnCase

  alias BirdsongQuizzer.Quizzes
  alias BirdsongQuizzer.Quizzes.Quiz

  @create_attrs %{
    answers: [],
    id: "some id",
    song_url: "some song_url"
  }
  @update_attrs %{
    answers: [],
    id: "some updated id",
    song_url: "some updated song_url"
  }
  @invalid_attrs %{answers: nil, id: nil, song_url: nil}

  def fixture(:quiz) do
    {:ok, quiz} = Quizzes.create_quiz(@create_attrs)
    quiz
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all questions", %{conn: conn} do
      conn = get(conn, Routes.quiz_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create quiz" do
    test "renders quiz when data is valid", %{conn: conn} do
      conn = post(conn, Routes.quiz_path(conn, :create), quiz: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.quiz_path(conn, :show, id))

      assert %{
               "id" => id,
               "answers" => [],
               "id" => "some id",
               "song_url" => "some song_url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.quiz_path(conn, :create), quiz: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update quiz" do
    setup [:create_quiz]

    test "renders quiz when data is valid", %{conn: conn, quiz: %Quiz{id: id} = quiz} do
      conn = put(conn, Routes.quiz_path(conn, :update, quiz), quiz: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.quiz_path(conn, :show, id))

      assert %{
               "id" => id,
               "answers" => [],
               "id" => "some updated id",
               "song_url" => "some updated song_url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, quiz: quiz} do
      conn = put(conn, Routes.quiz_path(conn, :update, quiz), quiz: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete quiz" do
    setup [:create_quiz]

    test "deletes chosen quiz", %{conn: conn, quiz: quiz} do
      conn = delete(conn, Routes.quiz_path(conn, :delete, quiz))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.quiz_path(conn, :show, quiz))
      end
    end
  end

  defp create_quiz(_) do
    quiz = fixture(:quiz)
    {:ok, quiz: quiz}
  end
end
