defmodule Day02Test do
  use ExUnit.Case

  import TestHelper

  test "part1" do
    assert Day02.part_1(input("day_02_example_1")) == 1_227_775_554
    assert Day02.part_1(input("day_02")) == 12_599_655_151
  end

  test "part2" do
    assert Day02.part_2(input("day_02_example_1")) == 4_174_379_265
    assert Day02.part_2(input("day_02")) == 20_942_028_255
  end
end
