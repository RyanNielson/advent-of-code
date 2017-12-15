defmodule AdventOfCode2017.Day15Test do
  use ExUnit.Case

  import AdventOfCode2017.Day15
  import AdventOfCode2017.TestHelper

  test "part1" do
    assert part1(sample_input_1()) == 588
    assert part1(input("test/input/day_15.txt")) == 638
  end

  test "part2" do
    assert part2(sample_input_1()) == 309
    assert part2(input("test/input/day_15.txt")) == 343
  end

  test "parse" do
    assert parse(sample_input_1()) == {65, 8921}
    assert parse(input("test/input/day_15.txt")) == {289, 629}
  end

  defp sample_input_1, do: "Generator A starts with 65\nGenerator B starts with 8921"
end