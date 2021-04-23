defmodule QuizlyModel.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset
  alias QuizlyModel.Quizzes.Quiz
  alias QuizlyModel.Games.Round

  schema "games" do
    field :round_seconds, :integer, default: 10
    field :started, :utc_datetime
    field :finished, :utc_datetime
    belongs_to :quiz, Quiz
    has_many :rounds, Round
  end

  def changeset(game, attrs \\ %{}) do
    game
    |> cast(attrs, [:round_seconds, :started, :finished, :quiz_id])
    |> validate_changeset()
  end

  defp validate_changeset(struct) do
    struct
    |> validate_required([:quiz_id])
  end
end
