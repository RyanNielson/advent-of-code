defmodule Day15Test do
  use ExUnit.Case

  import TestHelper
  import Day15

  test "part1" do
    assert part1(input("day_15_example_1"), 10) == 26
    assert part1(input("day_15"), 2_000_000) == 4_919_281
  end

  test "part2" do
    # assert part2(input("day_15_example_1")) == 123
    # assert part2(input("day_15")) == 456
  end
end
