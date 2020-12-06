defmodule Day06Test do
  use ExUnit.Case

  import Day06
  import TestHelper

  describe "Day05" do
    test "part1" do
      assert part1(input("day_06_example_1")) == 11
      assert part1(input("day_06")) == 6612
    end

    test "part2" do
      assert part2(input("day_06_example_1")) == 6
      assert part2(input("day_06")) == 3268
    end
  end
end
