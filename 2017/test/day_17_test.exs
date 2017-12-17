defmodule AdventOfCode2017.Day17Test do
  use ExUnit.Case

  import AdventOfCode2017.Day17
  import AdventOfCode2017.TestHelper

  test "part1" do
    assert part1("3") == 638
    assert part1(input("test/input/day_17.txt")) == 1173
  end

  test "parse" do
    assert parse(input("test/input/day_17.txt")) == 304
  end
end