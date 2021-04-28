defmodule QuizlySrv.QuizView do
  use QuizlySrv, :view

  def render("index.json", %{quizzes: quizzes}) do
    render_many(quizzes, __MODULE__, "game.json")
  end

  def render("show.json", %{quiz: quiz}) do
    render_one(quiz, __MODULE__, "game.json")
  end

  def render("game.json", %{quiz: quiz}) do
    %{id: quiz.id, name: quiz.name, description: quiz.description, creator_id: quiz.creator_id}
  end
end
