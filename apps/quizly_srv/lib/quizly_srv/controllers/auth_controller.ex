defmodule QuizlySrv.AuthController do
  use QuizlySrv, :controller
  alias QuizlyModel.Accounts.User

  @user_view QuizlySrv.UserView

  action_fallback QuizlySrv.FallbackController

  def sign_up(conn, %{"user" => user_attrs}) do
    with {:ok, %User{} = user} <- QuizlyModel.Accounts.create_user(user_attrs),
         {:ok, jwt, _claims} <- QuizlySrv.Guardian.GuardianImpl.encode_and_sign(user) do
      render(conn, @user_view, "show.json", user: user, jwt: jwt)
    end
  end

  def sign_in(conn, %{"username" => username, "password" => password}) do
    with {:ok, user} <- QuizlyModel.Accounts.authenticate_user(username, password),
         {:ok, jwt, _claims} <- QuizlySrv.Guardian.GuardianImpl.encode_and_sign(user) do
      render(conn, @user_view, "show.json", user: user, jwt: jwt)
    end
  end

  def refresh(conn, _params) do
    # DO REFRESH
    conn
  end
end
