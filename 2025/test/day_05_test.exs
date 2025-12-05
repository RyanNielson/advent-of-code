defmodule Day05Test do
  use ExUnit.Case

  import TestHelper

  test "part1" do
    assert Day05.part_1(input("day_05_example_1")) == 3
    assert Day05.part_1(input("day_05")) == 735
  end

  # test "part2" do
  #   assert Day04.part_2(input("day_04_example_1")) == 43
  #   assert Day04.part_2(input("day_04")) == 9784
  # end
end
