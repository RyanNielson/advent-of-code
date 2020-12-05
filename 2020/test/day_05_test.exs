defmodule Day05Test do
  use ExUnit.Case

  import Day05
  import TestHelper

  describe "Day05" do
    test "part1" do
      assert part1(input("day_05_example_1")) == 820
      assert part1(input("day_05")) == 871
    end

    test "part2" do
      assert part2(input("day_05")) == 640
    end
  end
end
