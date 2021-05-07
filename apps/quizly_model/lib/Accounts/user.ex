defmodule QuizlyModel.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias QuizlyModel.Accounts.User
  alias QuizlyModel.Quizzes.Quiz
  alias QuizlyModel.Games.RoundScore
  alias QuizlyModel.Games.UserAnswer
  alias QuizlyModel.Accounts.RefreshToken

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "users" do
    field :username, :string
    field :name, :string
    field :surname, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    has_many :quizzes, Quiz, foreign_key: :creator_id
    has_many :round_scores, RoundScore
    has_many :user_answers, UserAnswer
    has_many :refresh_tokens, RefreshToken
    timestamps()
  end

  def creation_changeset(attrs \\ %{}) do
    %User{}
    |> cast(attrs, [:username, :name, :surname, :password])
    |> validate_creation_changeset()
    |> put_password_hash()
  end

  def modification_changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:name, :surname])
    |> validate_update_changeset()
  end

  defp validate_creation_changeset(struct) do
    struct
    |> validate_required([:username, :name, :surname, :password])
    |> validate_format(:password, ~r/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).*/,
      message:
        "Password must include at least one lowercase letter, one uppercase letter, and one digit"
    )
    |> unique_constraint([:username])
  end

  defp validate_update_changeset(struct) do
    struct
    |> validate_required([:name, :surname])
  end

  defp put_password_hash(struct) do
    case struct do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(struct, :password_hash, Pbkdf2.hash_pwd_salt(password))

      _ ->
        struct
    end
  end
end
