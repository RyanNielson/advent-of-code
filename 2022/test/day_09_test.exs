defmodule Day09Test do
  use ExUnit.Case

  import TestHelper
  import Day09

  test "part1" do
    assert part1(input("day_09_example_1")) == 13
    assert part1(input("day_09")) == 6212
  end

  test "part2" do
    assert part2(input("day_09_example_1")) == 1
    assert part2(input("day_09_example_2")) == 36
    assert part2(input("day_09")) == 2522
  end
end
