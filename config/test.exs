use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :quizly_srv, QuizlySrv.Endpoint,
  http: [port: 4002],
  server: false

config :pbkdf2_elixir,
  rounds: 1
