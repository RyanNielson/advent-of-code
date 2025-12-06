defmodule Day06Test do
  use ExUnit.Case

  import TestHelper

  test "part1" do
    assert Day06.part_1(input("day_06_example_1", false)) == 4_277_556
    assert Day06.part_1(input("day_06", false)) == 6_635_273_135_233
  end

  test "part2" do
    assert Day06.part_2(input("day_06_example_1", false)) == 3_263_827
    assert Day06.part_2(input("day_06", false)) == 12_542_543_681_221
  end
end
