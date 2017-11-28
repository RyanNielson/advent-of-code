defmodule Day03Test do
  use ExUnit.Case
  doctest Day03

  test "run" do
    assert Day03.run(input_simple) == 1
    assert Day03.run(input) == 982
  end

  test "parse" do
    assert Day03.parse(input_simple) == [[5, 10, 25], [1, 2, 3], [5, 5, 6]]
  end

  defp input_simple do
    File.read!("test/input/day_03_simple.txt")
  end

  defp input do
    File.read!("test/input/day_03.txt")
  end
end
