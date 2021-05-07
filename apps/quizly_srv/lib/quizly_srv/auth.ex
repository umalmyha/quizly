defmodule QuizlySrv.Auth do
  import Plug.Conn, only: [fetch_cookies: 1]

  @refr_token_context QuizlySrv.Endpoint
  @refr_token_salt "refresh_token"

  def extract_refresh_token(conn) do
    fetch_cookies(conn)
    |> Map.from_struct()
    |> get_in([:cookies, "ex-phx-refresh-token"])
  end

  def generate_refresh_token(user) do
    Phoenix.Token.sign(@refr_token_context, @refr_token_salt, user.id)
  end
end
