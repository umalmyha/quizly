defmodule QuizlySrv.QuizController do
  use QuizlySrv, :controller
  alias QuizlyModel.Quizzes.Quiz

  action_fallback QuizlySrv.FallbackController

  def index(conn, _params) do
    quizzes = QuizlyModel.Quizzes.list_quizzes()
    render(conn, "index.json", quizzes: quizzes)
  end

  def show(conn, %{"id" => id}) do
    with %Quiz{} = quiz <- QuizlyModel.Quizzes.get_quiz(id) do
      render(conn, "show.json", quiz: quiz)
    end
  end

  def create(conn, %{"quiz" => quiz_attrs}) do
    with {:ok, %Quiz{} = quiz} <- QuizlyModel.Quizzes.create_quiz(quiz_attrs) do
      conn
      |> put_status(:created)
      |> render("show.json", quiz: quiz)
    end
  end

  def update(conn, %{"id" => id, "quiz" => quiz_attrs}) do
    with %Quiz{} = quiz <- QuizlyModel.Quizzes.get_quiz(id),
         {:ok, %Quiz{} = quiz} <- QuizlyModel.Quizzes.update_quiz(quiz, quiz_attrs) do
      render(conn, "show.json", quiz: quiz)
    end
  end

  def delete(conn, %{"id" => id}) do
    with %Quiz{} = quiz <- QuizlyModel.Quizzes.get_quiz(id),
         {:ok, _} <- QuizlyModel.Quizzes.delete_quiz(quiz) do
      send_resp(conn, :no_content, "")
    end
  end
end
