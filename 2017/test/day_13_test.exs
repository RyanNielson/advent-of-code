defmodule AdventOfCode2017.Day13Test do
  use ExUnit.Case

  import AdventOfCode2017.Day13
  import AdventOfCode2017.TestHelper

  test "part1" do
    assert part1(sample_input_1()) == 24
    assert part1(input("test/input/day_13.txt")) == 1624
  end

  test "part2" do
    assert part2(sample_input_1()) == 10
    assert part2(input("test/input/day_13.txt")) == 3923436
  end

  test "parse" do
    assert parse(sample_input_1()) == sample_layers_1()
  end

  defp sample_input_1, do: "0: 3\n1: 2\n4: 4\n6: 4"

  defp sample_layers_1, do: [{0, 3}, {1, 2}, {4, 4}, {6, 4}]
end