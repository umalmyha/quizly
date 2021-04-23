defmodule QuizlyModel.Accounts do
  alias QuizlyModel.Repo
  alias QuizlyModel.Accounts.User

  def list_users(), do: Repo.all(User)

  def get_user(id), do: Repo.get(User, id)

  def delete_user(%User{} = user), do: Repo.delete(user)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end
end
