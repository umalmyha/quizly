defmodule QuizlySrv.QuestionView do
  use QuizlySrv, :view

  def render("index.json", %{questions: questions}) do
    render_many(questions, __MODULE__, "question.json")
  end

  def render("show.json", %{question: question}) do
    render_one(question, __MODULE__, "question.json")
  end

  def render("question.json", %{question: question}) do
    %{id: question.id, text: question.text, quiz_id: question.quiz_id}
  end
end
