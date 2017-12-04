defmodule AdventOfCode2017.Day04Test do
  use ExUnit.Case

  import AdventOfCode2017.Day04
  import AdventOfCode2017.TestHelper

  test "part1" do
    assert part1(input("test/input/day_04.txt")) == 477
  end

  test "part2" do
    assert part2(input("test/input/day_04.txt")) == 167
  end
end