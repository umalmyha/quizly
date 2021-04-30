defmodule QuizlyModel.Accounts.RefreshToken do
  use Ecto.Schema
  import Ecto.Changeset
  alias QuizlyModel.Accounts.User

  @primay_key {:token, :string, autogenerate: false}
  @foreign_key_type :binary_id
  schema "refresh_tokens" do
    field :jwt_id, :binary_id
    field :invalidated, :boolean
    field :expiry_date, :date
    belongs_to :user, User
  end

  def changeset(token, attrs \\ %{}) do
    token
    |> cast(attrs, [:token, :jwt_id, :invalidated, :expiry_date, :user_id])
    |> validate_changeset()
  end

  defp validate_changeset(struct) do
    struct
    |> validate_required([:token, :jwt_id, :expirary_date, :user_id])
  end
end
