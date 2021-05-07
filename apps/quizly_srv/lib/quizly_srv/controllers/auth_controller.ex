defmodule QuizlySrv.AuthController do
  use QuizlySrv, :controller
  alias QuizlyModel.Accounts.User
  alias QuizlySrv.Auth.Jwt
  alias QuizlySrv.Auth.RefreshToken

  @user_view QuizlySrv.UserView
  @error_view QuizlySrv.ErrorView

  action_fallback(QuizlySrv.FallbackController)

  def sign_up(conn, %{"user" => user_attrs}) do
    with {:ok, %User{} = user} <- QuizlyModel.Accounts.create_user(user_attrs) do
      conn
      |> put_view(@user_view)
      |> render("show.json", user: user)
    end
  end

  def sign_in(conn, %{"username" => username, "password" => password}) do
    with {:ok, user} <- QuizlyModel.Accounts.authenticate_user(username, password) do
      jwt = Jwt.encode(user)
      refr_token = RefreshToken.encode(user)

      token_attrs = %{
        token: refr_token,
        jwt_id: Jwt.fetch_claim(jwt, "jti"),
        expiry_date: RefreshToken.get_expiry_date(),
        user_id: user.id
      }

      case QuizlyModel.Accounts.save_refresh_token(token_attrs) do
        {:ok, _} ->
          conn
          |> put_resp_cookie(RefreshToken.cookie_name(), refr_token, http_only: true)
          |> render("show.json", user: user, jwt: jwt.token, expiry: Jwt.get_exp_datetime(jwt))

        {:error, changeset} ->
          conn
          |> put_status(:bad_request)
          |> put_view(@error_view)
          |> render(:"400", changeset: changeset)
      end
    end
  end

  def refresh(conn, %{"jwt" => signed_jwt}) do
    with {:ok, signed_token} <- RefreshToken.extract(conn),
         token when not is_nil(token) <- QuizlyModel.Accounts.get_token_by_sign(signed_token),
         curr_jwt <- Jwt.decode(signed_jwt),
         {:ok, _} <-
           QuizlyModel.Accounts.verify_refresh(token, Jwt.get_verify_refr_attrs(curr_jwt)),
         new_jwt = Jwt.encode(%User{id: Jwt.fetch_claim(curr_jwt, "sub")}),
         {:ok, _} <-
           QuizlyModel.Accounts.update_refresh_token(token, %{
             jwt_id: Jwt.fetch_claim(new_jwt, "jti")
           }) do
      conn
      |> put_resp_cookie(RefreshToken.cookie_name(), signed_token, http_only: true)
      |> render("show.json", jwt: new_jwt.token, expiry: Jwt.get_exp_datetime(new_jwt))
    end
  end

  def logout(conn, _params) do
    with {:ok, signed_token} <- RefreshToken.extract(conn),
         token when not is_nil(token) <- QuizlyModel.Accounts.get_token_by_sign(signed_token),
         {:ok, _} <- QuizlyModel.Accounts.update_refresh_token(token, %{invalidated: true}) do
      conn
      |> delete_resp_cookie(RefreshToken.cookie_name(), http_only: true)
      |> send_resp(:ok, "")
    end
  end
end
