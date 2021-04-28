defmodule QuizlyModel.Quizzes.Quiz do
  use Ecto.Schema
  import Ecto.Changeset
  alias QuizlyModel.Accounts.User
  alias QuizlyModel.Quizzes.Question
  alias QuizlyModel.Games.Game

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "quizzes" do
    field :name, :string
    field :description, :string
    belongs_to :creator, User, foreign_key: :creator_id
    has_many :questions, Question
    has_many :games, Game
  end

  def changeset(quiz, attrs \\ %{}) do
    quiz
    |> cast(attrs, [:name, :description, :creator_id])
    |> validate_changeset()
  end

  defp validate_changeset(struct) do
    struct
    |> validate_required([:name, :creator_id])
    |> unique_constraint([:name])
  end
end
