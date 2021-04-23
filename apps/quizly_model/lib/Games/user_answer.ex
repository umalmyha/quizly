defmodule QuizlyModel.Games.UserAnswer do
  use Ecto.Schema
  import Ecto.Changeset
  alias QuizlyModel.Accounts.User
  alias QuizlyModel.Games.Round
  alias QuizlyModel.Quizzes.Option

  schema "user_answers" do
    belongs_to :user, User
    belongs_to :round, Round
    belongs_to :option, Option
  end

  def changeset(user_answer, attrs \\ %{}) do
    user_answer
    |> cast(attrs, [:user_id, :round_id, :option_id])
    |> validate_changeset()
  end

  defp validate_changeset(struct) do
    struct
    |> validate_required([:user_id, :round_id, :option_id])
  end
end
