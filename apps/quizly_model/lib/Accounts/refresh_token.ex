defmodule QuizlyModel.Accounts.RefreshToken do
  use Ecto.Schema
  import Ecto.Changeset
  alias QuizlyModel.Accounts.User
  alias QuizlyModel.Accounts.RefreshToken

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "refresh_tokens" do
    field :token, :string
    field :jwt_id, :binary_id
    field :invalidated, :boolean
    field :expiry_date, :date
    belongs_to :user, User
    timestamps()
  end

  def creation_changeset(attrs \\ %{}) do
    %RefreshToken{}
    |> cast(attrs, [:token, :jwt_id, :expiry_date, :user_id])
    |> validate_required([:token, :jwt_id, :expiry_date, :user_id])
  end

  def modification_changeset(refresh_token, attrs \\ %{}) do
    refresh_token
    |> cast(attrs, [:jwt_id, :invalidated])
    |> validate_required([:jwt_id, :invalidated])
  end
end
