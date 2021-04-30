defmodule QuizlySrv.Guardian.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :quizly_srv,
    error_handler: QuizlySrv.Guardian.ErrorHandler,
    module: QuizlySrv.Guardian.GuardianImpl

  plug Guardian.Plug.VerifyHeader, realm: "Bearer", claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
end
