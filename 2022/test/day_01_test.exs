defmodule Day01Test do
  use ExUnit.Case

  import TestHelper
  import Day01

  test "part1" do
    assert part1(input("day_01_example_1")) == 24000
    assert part1(input("day_01")) == 69177
  end

  test "part2" do
    assert part2(input("day_01_example_1")) == 45000
    assert part2(input("day_01")) == 207_456
  end
end
