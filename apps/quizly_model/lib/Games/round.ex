defmodule QuizlyModel.Games.Round do
  use Ecto.Schema
  import Ecto.Changeset
  alias QuizlyModel.Quizzes.Question
  alias QuizlyModel.Games.Game
  alias QuizlyModel.Games.RoundScore
  alias QuizlyModel.Games.UserAnswer

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "rounds" do
    field :number, :integer
    belongs_to :question, Question
    belongs_to :game, Game
    has_many :round_scores, RoundScore
    has_many :user_answers, UserAnswer
  end

  def changeset(round, attrs \\ %{}) do
    round
    |> cast(attrs, [:number, :question_id, :game_id])
    |> validate_changeset()
  end

  defp validate_changeset(struct) do
    struct
    |> validate_required([:number, :question_id, :game_id])
  end
end
