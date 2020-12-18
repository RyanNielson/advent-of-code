defmodule Day18Test do
  use ExUnit.Case

  import Day18
  import TestHelper

  describe "Day18" do
    test "part1" do
      assert part1(input("day_18_example_1")) == 71
      assert part1(input("day_18_example_2")) == 51
      assert part1(input("day_18_example_3")) == 26335
      assert part1(input("day_18")) == 1_451_467_526_514
    end

    test "part2" do
      assert part2(input("day_18_example_1")) == 231
      assert part2(input("day_18_example_2")) == 51
      assert part2(input("day_18_example_3")) == 693_891
      assert part2(input("day_18")) == 224_973_686_321_527
    end
  end
end
