defmodule QuizlySrv.UserController do
  use QuizlySrv, :controller
  alias QuizlyModel.Accounts.User

  action_fallback QuizlySrv.FallbackController

  def index(conn, _params) do
    users = QuizlyModel.Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def show(conn, %{"id" => id}) do
    with %User{} = user <- QuizlyModel.Accounts.get_user(id) do
      render(conn, "show.json", user: user)
    end
  end

  def create(conn, %{"user" => user_attrs}) do
    with {:ok, %User{} = user} <- QuizlyModel.Accounts.create_user(user_attrs) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    with %User{} = user <- QuizlyModel.Accounts.get_user(id),
         {:ok, %User{} = user} <- QuizlyModel.Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    with %User{} = user <- QuizlyModel.Accounts.get_user(id),
         {:ok, _} <- QuizlyModel.Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
