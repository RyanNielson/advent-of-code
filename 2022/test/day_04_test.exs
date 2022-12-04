defmodule Day04Test do
  use ExUnit.Case

  import TestHelper
  import Day04

  test "part1" do
    assert part1(input("day_04_example_1")) == 2
    assert part1(input("day_04")) == 431
  end

  # test "part2" do
  #   assert part2(input("day_04_example_1")) == 123
  #   assert part2(input("day_04")) == 456
  # end
end
