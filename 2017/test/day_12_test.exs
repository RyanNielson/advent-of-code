defmodule AdventOfCode2017.Day12Test do
  use ExUnit.Case

  import AdventOfCode2017.Day12
  import AdventOfCode2017.TestHelper

  test "parse" do
    assert parse(sample_input_1()) == sample_graph_1()
  end

  test "part1" do
    assert part1(sample_input_1()) == 6
    assert part1(input("test/input/day_12.txt")) == 141
  end

  test "part2" do
    assert part2(sample_input_1()) == 2
    assert part2(input("test/input/day_12.txt")) == 171
  end

  defp sample_input_1 do
    "0 <-> 2
    1 <-> 1
    2 <-> 0, 3, 4
    3 <-> 2, 4
    4 <-> 2, 3, 6
    5 <-> 6
    6 <-> 4, 5"
  end

  def sample_graph_1 do
    %{0 => [2], 1 => [1], 2 => [0, 3, 4], 3 => [2, 4], 4 => [2, 3, 6], 5 => [6], 6 => [4, 5]}
  end
end