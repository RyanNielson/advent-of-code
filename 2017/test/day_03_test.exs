defmodule AdventOfCode2017.Day03Test do
  use ExUnit.Case

  import AdventOfCode2017.Day03
  import AdventOfCode2017.TestHelper

  describe "Part 1" do
    test "part1" do
      assert part1("1") == 0
      assert part1("12") == 3
      assert part1("23") == 2
      assert part1("1024") == 31
      assert part1(input("test/input/day_03.txt")) == 480
    end

    test "build movement instructions" do
      assert build_movement_instructions(1, 1) == [{0, 0}]
      assert build_movement_instructions(3, 9) == [{0, 0}, {1, 0}, {0, 1}, {-1, 0}, {-1, 0}, {0, -1}, {0, -1}, {1, 0}, {1, 0}]
      assert build_movement_instructions(3, 7) == [{0, 0}, {1, 0}, {0, 1}, {-1, 0}, {-1, 0}, {0, -1}, {0, -1}]
    end

    test "closest odd power" do
      assert side_length(1) == 1
      assert side_length(9) == 3
      assert side_length(7) == 3
      assert side_length(10) == 5
      assert side_length(22) == 5
    end
  end

  describe "Part 2" do
    test "part2" do
      assert part2(input("test/input/day_03.txt")) == 349975
    end
  end
end
