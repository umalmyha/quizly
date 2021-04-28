defmodule QuizlyModel.Quizzes.Question do
  use Ecto.Schema
  import Ecto.Changeset
  alias QuizlyModel.Quizzes.Quiz
  alias QuizlyModel.Quizzes.Option
  alias QuizlyModel.Games.Round

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "questions" do
    field :text, :string
    belongs_to :quiz, Quiz
    has_many :options, Option
    has_many :rounds, Round
  end

  def changeset(quiz, attrs \\ %{}) do
    quiz
    |> cast(attrs, [:text, :quiz_id])
    |> validate_changeset()
  end

  defp validate_changeset(struct) do
    struct
    |> validate_required([:text, :quiz_id])
  end
end
