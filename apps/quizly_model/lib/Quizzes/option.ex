defmodule QuizlyModel.Quizzes.Option do
  use Ecto.Schema
  import Ecto.Changeset
  alias QuizlyModel.Quizzes.Question
  alias QuizlyModel.Games.UserAnswer

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "options" do
    field :text, :string
    field :is_correct, :boolean
    belongs_to :question, Question
    has_many :user_answers, UserAnswer
  end

  def changeset(option, attrs \\ %{}) do
    option
    |> cast(attrs, [:text, :is_correct])
    |> validate_changeset()
  end

  defp validate_changeset(struct) do
    struct
    |> validate_required([:text])
  end
end
