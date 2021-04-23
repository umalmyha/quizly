defmodule QuizlyModel.Quizzes do
  alias QuizlyModel.Repo
  alias QuizlyModel.Quizzes.{Quiz, Question, Option}

  def list_quizzes(), do: Repo.all(Quiz)

  def get_quiz(id), do: Repo.get(Quiz, id)

  def delete_quiz(%Quiz{} = quiz), do: Repo.delete(quiz)

  def create_quiz(attrs \\ %{}) do
    %Quiz{}
    |> Quiz.changeset(attrs)
    |> Repo.insert()
  end

  def update_quiz(%Quiz{} = quiz, attrs) do
    quiz
    |> Quiz.changeset(attrs)
    |> Repo.update()
  end

  def list_questions(), do: Repo.all(Question)

  def get_question(id), do: Repo.get(Question, id)

  def delete_question(%Question{} = question), do: Repo.delete(question)

  def create_question(attrs \\ %{}) do
    %Question{}
    |> Question.changeset(attrs)
    |> Repo.insert()
  end

  def update_question(%Question{} = question, attrs) do
    question
    |> Question.changeset(attrs)
    |> Repo.update()
  end

  def list_options(), do: Repo.all(Option)

  def get_option(id), do: Repo.get(Option, id)

  def delete_option(%Option{} = option), do: Repo.delete(option)

  def create_option(attrs \\ %{}) do
    %Option{}
    |> Option.changeset(attrs)
    |> Repo.insert()
  end

  def update_option(%Option{} = option, attrs) do
    option
    |> Option.changeset(attrs)
    |> Repo.update()
  end
end
