defmodule QuizlySrv.Auth.Jwt do
  defstruct [:token, claims: %{}]

  def encode(resource, claims \\ %{}) do
    {:ok, jwt, claims} = QuizlySrv.Guardian.GuardianImpl.encode_and_sign(resource, claims)
    %QuizlySrv.Auth.Jwt{token: jwt, claims: claims}
  end

  def decode_and_verify(signed_jwt, claims_to_check \\ %{}) do
    {:ok, claims} = QuizlySrv.Guardian.GuardianImpl.decode_and_verify(signed_jwt, claims_to_check)
    %QuizlySrv.Auth.Jwt{token: signed_jwt, claims: claims}
  end

  def decode(signed_jwt) do
    %{claims: claims} = QuizlySrv.Guardian.GuardianImpl.peek(signed_jwt)
    %QuizlySrv.Auth.Jwt{token: signed_jwt, claims: claims}
  end

  def fetch_claim(%QuizlySrv.Auth.Jwt{claims: claims}, claim) do
    Map.get(claims, claim)
  end

  def get_exp_datetime(%QuizlySrv.Auth.Jwt{} = jwt) do
    jwt
    |> fetch_claim("exp")
    |> QuizlySrv.Util.TimeUtil.datetime_from_unix_time()
  end

  def get_verify_refr_attrs(%QuizlySrv.Auth.Jwt{} = jwt) do
    %{jwt_expiry: get_exp_datetime(jwt), jti: fetch_claim(jwt, "jti")}
  end
end
