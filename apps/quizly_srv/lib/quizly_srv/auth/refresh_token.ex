defmodule QuizlySrv.Auth.RefreshToken do
  import Plug.Conn, only: [fetch_cookies: 1]

  @refr_token_context QuizlySrv.Endpoint
  @refr_token_salt "refresh_token"
  @refr_token_cookie "ex-phx-refresh-token"
  @refr_token_expiry_days 7

  def encode(user) do
    Phoenix.Token.sign(@refr_token_context, @refr_token_salt, user.id)
  end

  def extract(%Plug.Conn{} = conn) do
    case fetch_cookies(conn)
         |> Map.from_struct()
         |> get_in([:cookies, @refr_token_cookie]) do
      nil -> {:error, :no_refresh_token, :unathorized}
      token -> {:ok, token}
    end
  end

  def get_expiry_date() do
    QuizlySrv.Util.TimeUtil.date_from_today(@refr_token_expiry_days)
  end

  def cookie_name() do
    @refr_token_cookie
  end
end
