defmodule QuizlySrv.OptionController do
  use QuizlySrv, :controller
  alias QuizlyModel.Quizzes.Option

  def index(conn, _params) do
    options = QuizlyModel.Quizzes.list_options()
    render(conn, "index.json", options: options)
  end

  def show(conn, %{"id" => id}) do
    with %Option{} = option <- QuizlyModel.Quizzes.get_option(id) do
      render(conn, "show.json", option: option)
    end
  end

  def create(conn, %{"option" => option_attrs}) do
    with {:ok, %Option{} = option} <- QuizlyModel.Quizzes.create_option(option_attrs) do
      render(conn, "show.json", option: option)
    end
  end

  def update(conn, %{"id" => id, "option" => option_attrs}) do
    with %Option{} = option <- QuizlyModel.Quizzes.get_option(id),
         {:ok, %Option{} = option} <- QuizlyModel.Quizzes.update_option(option, option_attrs) do
      render(conn, "show.json", option: option)
    end
  end

  def delete(conn, %{"id" => id}) do
    with %Option{} = option <- QuizlyModel.Quizzes.get_option(id),
         {:ok, _} <- QuizlyModel.Quizzes.delete_option(option) do
      send_resp(conn, :no_content, "")
    end
  end
end
