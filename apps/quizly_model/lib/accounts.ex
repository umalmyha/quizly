defmodule QuizlyModel.Accounts do
  alias QuizlyModel.Repo
  alias QuizlyModel.Accounts.User
  alias QuizlyModel.Accounts.RefreshToken
  alias QuizlyModel.Accounts.RefreshVerification

  def list_users(), do: Repo.all(User)

  def get_user(id), do: Repo.get(User, id)

  def delete_user(%User{} = user), do: Repo.delete(user)

  def create_user(attrs \\ %{}) do
    User.creation_changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.modification_changeset(attrs)
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

  def save_refresh_token(attrs \\ %{}) do
    RefreshToken.creation_changeset(attrs)
    |> Repo.insert()
  end

  def verify_refresh(%RefreshToken{} = refresh_token, jwt_attrs \\ %{}) do
    changeset =
      build_refresh_verification_from_token(refresh_token, jwt_attrs)
      |> RefreshVerification.changeset()

    case changeset.valid? do
      true -> {:ok, changeset}
      false -> {:error, changeset}
    end
  end

  def update_refresh_token(%RefreshToken{} = refresh_token, attrs \\ %{}) do
    refresh_token
    |> RefreshToken.modification_changeset(attrs)
    |> Repo.update()
  end

  def get_token_by_sign(sign), do: Repo.get_by(RefreshToken, token: sign)

  defp build_refresh_verification_from_token(refresh_token, jwt_attrs) do
    refresh_token
    |> Map.take([:jwt_id, :invalidated, :expiry_date])
    |> Map.merge(jwt_attrs)
  end
end
