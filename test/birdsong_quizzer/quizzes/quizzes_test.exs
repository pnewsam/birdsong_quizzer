defmodule BirdsongQuizzer.QuizzesTest do
  use BirdsongQuizzer.DataCase

  alias BirdsongQuizzer.Quizzes

  describe "questions" do
    alias BirdsongQuizzer.Quizzes.Quiz

    @valid_attrs %{answers: [], id: "some id", song_url: "some song_url"}
    @update_attrs %{answers: [], id: "some updated id", song_url: "some updated song_url"}
    @invalid_attrs %{answers: nil, id: nil, song_url: nil}

    def quiz_fixture(attrs \\ %{}) do
      {:ok, quiz} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Quizzes.create_quiz()

      quiz
    end

    test "list_questions/0 returns all questions" do
      quiz = quiz_fixture()
      assert Quizzes.list_questions() == [quiz]
    end

    test "get_quiz!/1 returns the quiz with given id" do
      quiz = quiz_fixture()
      assert Quizzes.get_quiz!(quiz.id) == quiz
    end

    test "create_quiz/1 with valid data creates a quiz" do
      assert {:ok, %Quiz{} = quiz} = Quizzes.create_quiz(@valid_attrs)
      assert quiz.answers == []
      assert quiz.id == "some id"
      assert quiz.song_url == "some song_url"
    end

    test "create_quiz/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Quizzes.create_quiz(@invalid_attrs)
    end

    test "update_quiz/2 with valid data updates the quiz" do
      quiz = quiz_fixture()
      assert {:ok, %Quiz{} = quiz} = Quizzes.update_quiz(quiz, @update_attrs)
      assert quiz.answers == []
      assert quiz.id == "some updated id"
      assert quiz.song_url == "some updated song_url"
    end

    test "update_quiz/2 with invalid data returns error changeset" do
      quiz = quiz_fixture()
      assert {:error, %Ecto.Changeset{}} = Quizzes.update_quiz(quiz, @invalid_attrs)
      assert quiz == Quizzes.get_quiz!(quiz.id)
    end

    test "delete_quiz/1 deletes the quiz" do
      quiz = quiz_fixture()
      assert {:ok, %Quiz{}} = Quizzes.delete_quiz(quiz)
      assert_raise Ecto.NoResultsError, fn -> Quizzes.get_quiz!(quiz.id) end
    end

    test "change_quiz/1 returns a quiz changeset" do
      quiz = quiz_fixture()
      assert %Ecto.Changeset{} = Quizzes.change_quiz(quiz)
    end
  end
end
