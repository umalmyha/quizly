defmodule QuizlyModel.Repo.Migrations.InitQuizModel do
  use Ecto.Migration

  def change do
    create table(:quizzes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :description, :string
      add :creator_id, references(:users, type: :uuid)
    end

    create unique_index(:quizzes, [:creator_id])

    create table(:questions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :text, :string, null: false
      add :quiz_id, references(:quizzes, type: :uuid)
    end

    create unique_index(:questions, [:quiz_id])

    create table(:options, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :text, :string, null: false
      add :is_correct, :boolean, default: false
      add :question_id, references(:questions, type: :uuid)
    end

    create unique_index(:options, [:question_id])

    create table(:games, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :round_seconds, :integer, default: 10
      add :quiz_id, references(:quizzes, type: :uuid)
    end

    create unique_index(:games, [:quiz_id])

    create table(:rounds, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :number, :integer, null: false
      add :question_id, references(:questions, type: :uuid)
      add :game_id, references(:games, type: :uuid)
    end

    create unique_index(:rounds, [:question_id])
    create unique_index(:rounds, [:game_id])

    create table(:user_answers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, type: :uuid)
      add :round_id, references(:rounds, type: :uuid)
      add :option_id, references(:options, type: :uuid)
    end

    create unique_index(:user_answers, [:user_id])
    create unique_index(:user_answers, [:round_id])
    create unique_index(:user_answers, [:option_id])

    create table(:round_scores, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, type: :uuid)
      add :scores, :integer, default: 0
    end

    create unique_index(:round_scores, [:user_id])
  end
end
