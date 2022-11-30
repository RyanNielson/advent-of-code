defmodule Day01Test do
  use ExUnit.Case

  import TestHelper
  import Day01

  test "part1" do
    assert part1(input("day_01_example_1")) == 123
    assert part1(input("day_01")) == 456
  end

  test "part2" do
    assert part2(input("day_01_example_1")) == 123
    assert part2(input("day_01")) == 456
  end
end
