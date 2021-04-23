defmodule QuizlyModel.Repo.Migrations.InitModelAdjustment do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :is_admin
    end

    alter table(:questions) do
      modify :quiz_id, :uuid, on_delete: :delete_all
    end

    alter table(:options) do
      modify :question_id, :uuid, on_delete: :delete_all
    end
  end
end
