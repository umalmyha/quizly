defmodule QuizlyModel.Repo.Migrations.RefreshTokens do
  use Ecto.Migration

  def change do
    create table(:refresh_tokens, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :token, :string, null: false
      add :jwt_id, :uuid, null: false
      add :invalidated, :boolean, default: false
      add :expiry_date, :date, null: false
      add :user_id, references(:users, type: :uuid), null: false
      timestamps()
    end

    create unique_index(:refresh_tokens, [:token])
  end
end
