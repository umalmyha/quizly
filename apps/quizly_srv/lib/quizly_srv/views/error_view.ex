defmodule QuizlySrv.ErrorView do
  use QuizlySrv, :view

  def render("400.json", %{changeset: changeset}) do
    %{errors: translate_changeset_errors(changeset)}
  end

  def render("401.json", %{auth_error: error}) do
    case error do
      :invalid_username -> %{message: "User doesn't exist"}
      :invalid_password -> %{message: "Invalid password"}
    end
  end

  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end
end
