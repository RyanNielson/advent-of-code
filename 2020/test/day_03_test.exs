defmodule Day02Test do
  use ExUnit.Case

  import Day03
  import TestHelper

  describe "Day03" do
    test "part1" do
      assert part1(input("day_03_example_1")) == 7
      assert part1(input("day_03")) == 278
    end

    test "part2" do
      assert part2(input("day_03_example_1")) == 336
      assert part2(input("day_03")) == 9_709_761_600
    end
  end
end
