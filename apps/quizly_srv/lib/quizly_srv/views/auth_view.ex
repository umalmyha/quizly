defmodule QuizlySrv.AuthView do
  @user_view QuizlySrv.UserView

  def render("show.json", %{user: user, jwt: jwt, expiry: expiry}) do
    %{
      user: @user_view.render("user.json", user: user),
      token: %{jwt: jwt, expiry: expiry}
    }
  end

  def render("show.json", %{jwt: jwt, expiry: expiry}) do
    %{token: %{jwt: jwt, expiry: expiry}}
  end
end
