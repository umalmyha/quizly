defmodule QuizlySrv.Guardian.ErrorHandler do
  import Plug.Conn, only: [send_resp: 3]

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, _reason}, _opts) do
    send_resp(conn, :unauthorized, to_string(type))
  end
end
