defmodule Day13Test do
  use ExUnit.Case

  import Day13
  import TestHelper

  describe "Day13" do
    test "part1" do
      assert part1(input("day_13_example_1")) == 295
      assert part1(input("day_13")) == 3269
    end

    test "part2" do
      assert part2(input("day_13_example_1")) == 1_068_781
      assert part2(input("day_13_example_2")) == 3417
      assert part2(input("day_13_example_3")) == 754_018
      assert part2(input("day_13_example_4")) == 779_210
      assert part2(input("day_13_example_5")) == 1_261_476
      assert part2(input("day_13_example_6")) == 1_202_161_486
      assert part2(input("day_13")) == 672_754_131_923_874
    end
  end
end
