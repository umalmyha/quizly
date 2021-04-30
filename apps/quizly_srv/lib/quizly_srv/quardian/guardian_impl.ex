defmodule QuizlySrv.Guardian.GuardianImpl do
  use Guardian, otp_app: :quizly_srv
  alias QuizlyModel.Accounts.User

  def subject_for_token(%User{} = user, _claims) do
    {:ok, to_string(user.id)}
  end

  def subject_for_token(_, _) do
    {:error, :resource_not_found}
  end

  def resource_from_claims(%{"sub" => user_id}) do
    {:ok, QuizlyModel.Accounts.get_user(user_id)}
  end

  def resource_from_claims(_claims) do
    {:error, :no_claim_sub}
  end
end
