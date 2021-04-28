defmodule QuizlySrv.Router do
  use QuizlySrv, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", QuizlySrv do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    resources "/quizzes", QuizController, except: [:new, :edit]
    resources "/questions", QuestionController, except: [:new, :edit]
    resources "/options", OptionController, except: [:new, :edit]
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: QuizlySrv.Telemetry
    end
  end
end
