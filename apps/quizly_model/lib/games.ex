defmodule QuizlyModel.Games do
  alias QuizlyModel.Repo
  alias QuizlyModel.Games.{Game, Round, RoundScore, UserAnswer}

  def list_games(), do: Repo.all(Game)

  def get_game(id), do: Repo.get(Game, id)

  def delete_game(%Game{} = game), do: Repo.delete(game)

  def create_game(attrs \\ %{}) do
    %Game{}
    |> Game.changeset(attrs)
    |> Repo.insert()
  end

  def update_game(%Game{} = game, attrs) do
    game
    |> Game.changeset(attrs)
    |> Repo.update()
  end

  def list_rounds(), do: Repo.all(Round)

  def get_round(id), do: Repo.get(Round, id)

  def delete_round(%Round{} = round), do: Repo.delete(round)

  def create_round(attrs \\ %{}) do
    %Round{}
    |> Round.changeset(attrs)
    |> Repo.insert()
  end

  def update_round(%Game{} = round, attrs) do
    round
    |> Round.changeset(attrs)
    |> Repo.update()
  end

  def list_round_scores(), do: Repo.all(RoundScore)

  def get_round_score(id), do: Repo.get(RoundScore, id)

  def delete_round_score(%RoundScore{} = round_score), do: Repo.delete(round_score)

  def create_round_score(attrs \\ %{}) do
    %RoundScore{}
    |> RoundScore.changeset(attrs)
    |> Repo.insert()
  end

  def update_round_score(%RoundScore{} = round_score, attrs) do
    round_score
    |> RoundScore.changeset(attrs)
    |> Repo.update()
  end

  def list_user_answers(), do: Repo.all(UserAnswer)

  def get_user_answer(id), do: Repo.get(UserAnswer, id)

  def delete_user_answer(%UserAnswer{} = user_answer), do: Repo.delete(user_answer)

  def create_user_answer(attrs \\ %{}) do
    %UserAnswer{}
    |> UserAnswer.changeset(attrs)
    |> Repo.insert()
  end

  def update_user_answer(%UserAnswer{} = user_answer, attrs) do
    user_answer
    |> UserAnswer.changeset(attrs)
    |> Repo.update()
  end
end
