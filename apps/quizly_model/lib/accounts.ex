defmodule QuizlyModel.Accounts do
  alias QuizlyModel.Repo
  alias QuizlyModel.Accounts.User
  alias QuizlyModel.Accounts.RefreshToken

  def list_users(), do: Repo.all(User)

  def get_user(id), do: Repo.get(User, id)

  def delete_user(%User{} = user), do: Repo.delete(user)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset_for_create(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset_for_update(attrs)
    |> Repo.update()
  end

  def authenticate_user(username, password) do
    case Repo.get_by(User, username: username) do
      nil ->
        Pbkdf2.no_user_verify()
        {:error, :invalid_username}

      user ->
        if Pbkdf2.verify_pass(password, user.password_hash),
          do: {:ok, user},
          else: {:error, :invalid_password}
    end
  end

  def create_refresh_token(attrs \\ %{}) do
    %RefreshToken{}
    |> RefreshToken.changeset(attrs)
    |> Repo.insert()
  end

  def update_refresh_token(%RefreshToken{} = refresh_token, attrs \\ %{}) do
    refresh_token
    |> RefreshToken.changeset(attrs)
    |> Repo.update()
  end

  def get_refresh_token(token), do: Repo.get(RefreshToken, token)
end
