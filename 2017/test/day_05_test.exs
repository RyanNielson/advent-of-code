defmodule AdventOfCode2017.Day05Test do
  use ExUnit.Case

  import AdventOfCode2017.Day05
  import AdventOfCode2017.TestHelper

  test "part1" do
    assert part1(input_sample()) == 5
    assert part1(input("test/input/day_05.txt")) == 343467
  end

  test "part2" do
    assert part2(input_sample()) == 10
    assert part2(input("test/input/day_05.txt")) == 24774780
  end

  defp input_sample, do: "0\n3\n0\n1\n-3"
end