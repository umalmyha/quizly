defmodule QuizlyModel.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      QuizlyModel.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: QuizlyModel.PubSub}
      # Start a worker by calling: QuizlyModel.Worker.start_link(arg)
      # {QuizlyModel.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: QuizlyModel.Supervisor)
  end
end
