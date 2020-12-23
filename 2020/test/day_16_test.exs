defmodule Day16Test do
  use ExUnit.Case

  import Day16
  import TestHelper

  describe "Day16" do
    test "part1" do
      # assert part1(input("day_16_example_1")) == 71
      # assert part1(input("day_16")) == 20975
    end

    test "part2" do
      assert part2(input("day_16_example_2")) == 1
    end
  end
end
