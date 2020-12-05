defmodule Day04Test do
  use ExUnit.Case

  import Day04
  import TestHelper

  describe "Day04" do
    test "part1" do
      assert part1(input("day_04_example_1")) == 2
      assert part1(input("day_04")) == 245
    end

    test "part2" do
      assert part2(input("day_04_example_2")) == 4
      assert part2(input("day_04")) == 133
    end
  end
end
