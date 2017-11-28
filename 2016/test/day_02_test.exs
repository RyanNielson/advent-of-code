defmodule Day02Test do
  use ExUnit.Case
  doctest Day02

  test "run" do
    assert Day02.run(input_simple) == "1985"
    assert Day02.run(input) == "73597"
  end

  test "parse" do
    assert Day02.parse(input_simple) == [["U", "L", "L"], ["R", "R", "D", "D", "D"], ["L", "U", "R", "D", "L"], ["U", "U", "U", "U", "D"]]
  end

  defp input_simple do
    File.read!("test/input/day_02_simple.txt")
  end

  defp input do
    File.read!("test/input/day_02.txt")
  end
end
