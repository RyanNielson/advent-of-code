defmodule AdventOfCode2017.Day01Test do
  use ExUnit.Case

  import AdventOfCode2018.Day01
  import AdventOfCode2018.TestHelper

  # describe "Part 1" do
    test "part1" do
        assert part1("+1, +1, +1") == 3
        assert part1("+1, +1, -2") == 0
        assert part1("-1, -2, -3") == -6
        assert part1(input("test/input/day_01.txt")) == 547
    end

    test "part2" do
      assert part2("+1, -1") == 0
      assert part2("+3, +3, +4, -2, -4") == 10
      assert part2("-6, +3, +8, +5, -6") == 5
      assert part2("+7, +7, -2, -7, -4") == 14
      assert part2(input("test/input/day_01.txt")) == 76414
    end
end