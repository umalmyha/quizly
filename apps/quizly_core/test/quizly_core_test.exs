defmodule QuizlyCoreTest do
  use ExUnit.Case
  doctest QuizlyCore

  test "greets the world" do
    assert QuizlyCore.hello() == :world
  end
end
