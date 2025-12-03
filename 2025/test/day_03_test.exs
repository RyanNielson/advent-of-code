defmodule Day03Test do
  use ExUnit.Case

  import TestHelper

  test "part1" do
    assert Day03.part_1(input("day_03_example_1")) == 357
    assert Day03.part_1(input("day_03")) == 17324
  end

  test "part2" do
    assert Day03.part_2(input("day_03_example_1")) == 3_121_910_778_619
    assert Day03.part_2(input("day_03")) == 171_846_613_143_331
  end
end
