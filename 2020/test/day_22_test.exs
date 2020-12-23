defmodule Day22Test do
  use ExUnit.Case

  import Day22
  import TestHelper

  describe "Day22" do
    test "part1" do
      assert part1(input("day_22_example_1")) == 306
      assert part1(input("day_22")) == 34255
    end

    test "part2" do
      assert part2(input("day_22_example_1")) == 291
      assert part2(input("day_22")) == 33369
    end
  end
end
