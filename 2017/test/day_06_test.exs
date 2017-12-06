defmodule AdventOfCode2017.Day06Test do
  use ExUnit.Case

  import AdventOfCode2017.Day06
  import AdventOfCode2017.TestHelper

    test "part1" do
      assert part1("0 2 7 0") == 5
      assert part1(input("test/input/day_06.txt")) == 4074
    end

    test "part2" do
      assert part2("0 2 7 0") == 4
      assert part2(input("test/input/day_06.txt")) == 2793
    end

    test "parse" do
      assert parse(input("test/input/day_06.txt")) == [11, 11, 13, 7, 0, 15, 5, 5, 4, 4, 1, 1, 7, 1, 15, 11]
    end

    test "largest bank" do
      assert largest_bank([5, 2, 8, 8, 8]) == {8, 2}
      assert largest_bank([11, 11, 13, 7, 0, 15, 5, 5, 4, 4, 1, 1, 7, 1, 15, 11]) == {15, 5}
    end

    test "redistribute" do
      assert redistribute([0, 2, 7, 0]) == [2, 4, 1, 2]
      assert redistribute([2, 4, 1, 2]) == [3, 1, 2, 3]
      assert redistribute([3, 1, 2, 3]) == [0, 2, 3, 4]
      assert redistribute([0, 2, 3, 4]) == [1, 3, 4, 1]
      assert redistribute([1, 3, 4, 1]) == [2, 4, 1, 2]
    end
end