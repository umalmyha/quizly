defmodule QuizlyModel.Repo.Migrations.Users do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :username, :string
      add :name, :string
      add :surname, :string
      add :password_hash, :string
      add :is_admin, :boolean, default: false
      timestamps()
    end

    create unique_index(:users, [:username])
  end
end
