defmodule Day05Test do
  use ExUnit.Case
  doctest Day05

  @tag timeout: 600000
  test "run" do
    assert Day05.run(input_simple) == "18F47A30"
    assert Day05.run(input) == "1A3099AA"
  end

  defp input_simple, do: "abc"
  defp input, do: "uqwqemis"
end
