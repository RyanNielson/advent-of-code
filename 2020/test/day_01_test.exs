defmodule Day01Test do
  use ExUnit.Case

  import Day01
  import TestHelper

  describe "Day01" do
    test "part1" do
      assert part1(input("day_01_example_1")) == 514_579
      assert part1(input("day_01")) == 73371
    end

    test "part2" do
      assert part2(input("day_01_example_1")) == 241_861_950
      assert part2(input("day_01")) == 127_642_310
    end
  end
end
