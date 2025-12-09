defmodule Day09Test do
  use ExUnit.Case

  import TestHelper

  test "part1" do
    assert Day09.part_1(input("day_09_example_1")) == 50
    assert Day09.part_1(input("day_09")) == 1594
  end

  # test "part2" do
  #   assert Day09.part_2(input("day_09_example_1")) == 40
  #   assert Day09.part_2(input("day_09")) == 15_650_261_281_478
  # end
end
