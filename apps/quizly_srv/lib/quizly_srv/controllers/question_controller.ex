defmodule QuizlySrv.QuestionController do
  use QuizlySrv, :controller
  alias QuizlyModel.Quizzes.Question

  action_fallback QuizlySrv.FallbackController

  def index(conn, _params) do
    questions = QuizlyModel.Quizzes.list_questions()
    render(conn, "index.json", questions: questions)
  end

  def show(conn, %{"id" => id}) do
    with %Question{} = question <- QuizlyModel.Quizzes.get_question(id) do
      render(conn, "show.json", question: question)
    end
  end

  def create(conn, %{"question" => question_attrs}) do
    with {:ok, %Question{} = question} <- QuizlyModel.Quizzes.create_question(question_attrs) do
      conn
      |> put_status(:created)
      |> render("show.json", question: question)
    end
  end

  def update(conn, %{"id" => id, "question" => question_attrs}) do
    with %Question{} = question <- QuizlyModel.Quizzes.get_question(id),
         {:ok, %Question{} = question} <-
           QuizlyModel.Quizzes.update_question(question, question_attrs) do
      render(conn, "show.json", question: question)
    end
  end

  def delete(conn, %{"id" => id}) do
    with %Question{} = question <- QuizlyModel.Quizzes.get_question(id),
         {:ok, _} <- QuizlyModel.Quizzes.delete_question(question) do
      send_resp(conn, :no_content, "")
    end
  end
end
