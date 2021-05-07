defmodule QuizlySrv.FallbackController do
  use QuizlySrv, :controller

  @error_view QuizlySrv.ErrorView

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(@error_view)
    |> render(:"400", changeset: changeset)
  end

  def call(conn, {:error, auth_error})
      when auth_error in [:invalid_username, :invalid_password] do
    conn
    |> put_status(:unauthorized)
    |> put_view(@error_view)
    |> render(:"401", auth_error: auth_error)
  end

  def call(conn, {:error, _}) do
    conn
    |> put_status(:bad_request)
    |> put_view(@error_view)
    |> render(:"400")
  end

  def call(conn, nil) do
    conn
    |> put_status(:not_found)
    |> put_view(@error_view)
    |> render(:"404")
  end
end
