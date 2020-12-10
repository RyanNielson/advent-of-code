defmodule Day09Test do
  use ExUnit.Case

  import Day09
  import TestHelper

  describe "Day09" do
    test "part1" do
      assert part1(input("day_09_example_1"), 5) == 127
      assert part1(input("day_09")) == 32_321_523
    end

    test "part2" do
      assert part2(input("day_09_example_1"), 5) == 62
      assert part2(input("day_09")) == 4_794_981
    end
  end
end
