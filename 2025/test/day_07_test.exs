defmodule Day07Test do
  use ExUnit.Case

  import TestHelper

  test "part1" do
    assert Day07.part_1(input("day_07_example_1")) == 21
    assert Day07.part_1(input("day_07")) == 1594
  end

  # test "part2" do
  #   assert Day07.part_2(input("day_07_example_1")) == 3_263_827
  #   assert Day07.part_2(input("day_07")) == 12_542_543_681_221
  # end
end
