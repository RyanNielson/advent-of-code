defmodule Day07Test do
  use ExUnit.Case

  import Day07
  import TestHelper

  describe "Day07" do
    test "part1" do
      assert part1(input("day_07_example_1")) == 4
      assert part1(input("day_07")) == 222
    end

    test "part2" do
      assert part2(input("day_07_example_1")) == 32
      assert part2(input("day_07_example_2")) == 126
      assert part2(input("day_07")) == 13264
    end
  end
end
