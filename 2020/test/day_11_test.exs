defmodule Day11Test do
  use ExUnit.Case

  import Day11
  import TestHelper

  describe "Day11" do
    test "part1" do
      assert part1(input("day_11_example_1")) == 37
      assert part1(input("day_11")) == 2265
    end

    test "part2" do
      assert part2(input("day_11_example_1")) == 26
      assert part2(input("day_11")) == 2045
    end
  end
end
