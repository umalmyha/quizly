defmodule QuizlyModel.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias QuizlyModel.Quizzes.Quiz
  alias QuizlyModel.Games.RoundScore
  alias QuizlyModel.Games.UserAnswer

  schema "users" do
    field :usernamae, :string
    field :name, :string
    field :surname, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    has_many :quizzes, Quiz, foreign_key: :creator_id
    has_many :round_scores, RoundScore
    has_many :user_answers, UserAnswer
    timestamps()
  end

  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:username, :name, :surname, :password])
    |> validate_changeset()
  end

  defp validate_changeset(struct) do
    struct
    |> validate_required([:username, :name, :surname, :password])
    |> validate_format(:password, ~r/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).*/,
      message:
        "Password must include at least one lowercase letter, one uppercase letter, and one digit"
    )
    |> unique_constraint([:username])
  end
end
