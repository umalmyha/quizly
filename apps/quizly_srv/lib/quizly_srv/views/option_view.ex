defmodule QuizlySrv.OptionView do
  use QuizlySrv, :view

  def render("index.json", %{options: options}) do
    render_many(options, __MODULE__, "option.json")
  end

  def render("show.json", %{option: option}) do
    render_one(option, __MODULE__, option: option)
  end

  def render("option.json", %{option: option}) do
    %{
      id: option.id,
      text: option.text,
      is_correct: option.is_correct,
      question_id: option.question_id
    }
  end
end
