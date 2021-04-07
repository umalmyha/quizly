defmodule QuizlySrv.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      QuizlySrv.Telemetry,
      # Start the Endpoint (http/https)
      QuizlySrv.Endpoint
      # Start a worker by calling: QuizlySrv.Worker.start_link(arg)
      # {QuizlySrv.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: QuizlySrv.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    QuizlySrv.Endpoint.config_change(changed, removed)
    :ok
  end
end
