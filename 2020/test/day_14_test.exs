defmodule Day14Test do
  use ExUnit.Case

  import Day14
  import TestHelper

  describe "Day14" do
    test "part1" do
      assert part1(input("day_14_example_1")) == 165
      assert part1(input("day_14")) == 18_630_548_206_046
    end

    test "part2" do
      assert part2(input("day_14_example_2")) == 208
      # assert part2(input("day_13_example_2")) == 3417
      # assert part2(input("day_13_example_3")) == 754_018
      # assert part2(input("day_13_example_4")) == 779_210
      # assert part2(input("day_13_example_5")) == 1_261_476
      # assert part2(input("day_13_example_6")) == 1_202_161_486
      # assert part2(input("day_13")) == 672_754_131_923_874
    end
  end
end
