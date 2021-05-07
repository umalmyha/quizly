defmodule QuizlyModel.Accounts.RefreshVerification do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :jwt_id, :binary_id
    field :invalidated, :boolean
    field :expiry_date, :date
    field :jwt_expiry, :utc_datetime
    field :jti, :binary_id
  end

  def changeset(attrs \\ %{}) do
    %QuizlyModel.Accounts.RefreshVerification{}
    |> change(attrs)
    |> validate_required([:jwt_id, :jwt_expiry, :invalidated, :expiry_date, :jti])
    |> validate_jwt_expired()
    |> validate_refr_token_not_expired()
    |> validate_refr_token_valid()
    |> validate_refr_token_jwt()
  end

  defp validate_jwt_expired(changeset) do
    validate_change(changeset, :jwt_expiry, fn _, jwt_expiry ->
      case DateTime.compare(DateTime.shift_zone!(jwt_expiry, "Etc/UTC"), DateTime.utc_now()) do
        :gt -> [jwt_expiry: "JWT is not expired yet"]
        _ -> []
      end
    end)
  end

  defp validate_refr_token_not_expired(changeset) do
    validate_change(changeset, :expiry_date, fn _, expiry_date ->
      case Date.compare(Date.utc_today(), expiry_date) do
        :gt -> [expiry_date: "Refresh token has expired"]
        _ -> []
      end
    end)
  end

  defp validate_refr_token_valid(changeset) do
    validate_change(changeset, :invalidated, fn _, invalidated ->
      case invalidated do
        true -> [invalidated: "This refresh token has been invalidated"]
        false -> []
      end
    end)
  end

  defp validate_refr_token_jwt(changeset) do
    validate_change(changeset, :jwt_id, fn _, jwt_id ->
      case jwt_id == fetch_change!(changeset, :jti) do
        true -> []
        false -> [jwt_id: "Refresh token doesn't match JWT"]
      end
    end)
  end
end
