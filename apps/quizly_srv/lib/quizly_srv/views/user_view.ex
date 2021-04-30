defmodule QuizlySrv.UserView do
  use QuizlySrv, :view

  def render("index.json", %{users: users}) do
    render_many(users, __MODULE__, "user.json")
  end

  def render("show.json", %{user: user, jwt: jwt}) do
    %{user: render_one(user, __MODULE__, "user.json"), jwt: jwt}
  end

  def render("show.json", %{user: user}) do
    render_one(user, __MODULE__, "user.json")
  end

  def render("user.json", %{user: user}) do
    %{id: user.id, username: user.username, name: user.name, surname: user.surname}
  end
end
