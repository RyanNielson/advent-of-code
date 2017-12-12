defmodule AdventOfCode2017.Day11Test do
  use ExUnit.Case

  import AdventOfCode2017.Day11
  import AdventOfCode2017.TestHelper

  test "parse" do
    assert parse(sample_input_1()) == ["ne", "ne", "ne"]
    assert parse(sample_input_2()) == ["ne", "ne", "sw", "sw"]
    assert parse(sample_input_3()) == ["ne", "ne", "s", "s"]
    assert parse(sample_input_4()) == ["se", "sw", "se", "sw", "sw"]
  end

  test "part1" do
    assert part1(sample_input_1()) == 3
    assert part1(sample_input_2()) == 0
    assert part1(sample_input_3()) == 2
    assert part1(sample_input_4()) == 3
    assert part1(input("test/input/day_11.txt")) == 675
  end

  test "part2" do
    assert part2(input("test/input/day_11.txt")) == 1424
  end


  defp sample_input_1, do: "ne,ne,ne"
  defp sample_input_2, do: "ne,ne,sw,sw"
  defp sample_input_3, do: "ne,ne,s,s"
  defp sample_input_4, do: "se,sw,se,sw,sw"
end