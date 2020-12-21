defmodule Day20Test do
  use ExUnit.Case

  import Day20
  import TestHelper

  describe "Day20" do
    test "part1" do
      assert part1(input("day_20_example_1")) == 5
      assert part1(input("day_20")) == 2436
    end

    # test "part2" do
    #   assert part2(input("day_18_example_1")) == 231
    #   assert part2(input("day_18_example_2")) == 51
    #   assert part2(input("day_18_example_3")) == 693_891
    #   assert part2(input("day_18")) == 224_973_686_321_527
    # end
  end
end
