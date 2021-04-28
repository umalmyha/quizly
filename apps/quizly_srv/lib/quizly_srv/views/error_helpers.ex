defmodule QuizlySrv.ErrorHelpers do
  def translate_changeset_errors(%Ecto.Changeset{} = changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  def translate_error({msg, opts}) do
    if count = opts[:count] do
      Gettext.dngettext(QuizlySrv.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(QuizlySrv.Gettext, "errors", msg, opts)
    end
  end
end
