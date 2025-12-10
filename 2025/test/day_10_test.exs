defmodule Day10Test do
  use ExUnit.Case

  import TestHelper

  test "part1" do
    assert Day10.part_1(input("day_10_example_1")) == 7
    assert Day10.part_1(input("day_10")) == 486
  end

  # test "part2" do
  #   assert Day09.part_2(input("day_09_example_1")) == 40
  #   assert Day09.part_2(input("day_09")) == 15_650_261_281_478
  # end
end
