defmodule QuizlyModel.Games.RoundScore do
  use Ecto.Schema
  import Ecto.Changeset
  alias QuizlyModel.Accounts.User
  alias QuizlyModel.Games.Round

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "round_scores" do
    field :scores, :integer, default: 0
    belongs_to :user, User
    belongs_to :round, Round
  end

  def changeset(round_score, attrs \\ %{}) do
    round_score
    |> cast(attrs, [:scores, :user_id, :round_id])
    |> validate_changeset()
  end

  defp validate_changeset(struct) do
    struct
    |> validate_required([:user_id, :round_id])
  end
end
