defmodule QuizlyModel.Repo do
  use Ecto.Repo,
    otp_app: :quizly_model,
    adapter: Ecto.Adapters.Postgres
end
