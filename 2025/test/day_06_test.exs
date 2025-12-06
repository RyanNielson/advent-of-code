defmodule Day06Test do
  use ExUnit.Case

  import TestHelper

  test "part1" do
    assert Day06.part_1(input("day_06_example_1")) == 4_277_556
    assert Day06.part_1(input("day_06")) == 6_635_273_135_233
  end

  # test "part2" do
  #   assert Day05.part_2(input("day_05_example_1")) == 14
  #   assert Day05.part_2(input("day_05")) == 344_306_344_403_172
  # end
end
