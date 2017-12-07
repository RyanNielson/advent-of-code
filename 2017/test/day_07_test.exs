defmodule AdventOfCode2017.Day07Test do
  use ExUnit.Case

  import AdventOfCode2017.Day07
  import AdventOfCode2017.TestHelper

    test "part1" do
      assert part1(sample_input_1()) == "tknk"
      assert part1(input("test/input/day_07.txt")) == "dgoocsw"
    end

    defp sample_input_1 do
      "pbga (66)
      xhth (57)
      ebii (61)
      havc (66)
      ktlj (57)
      fwft (72) -> ktlj, cntj, xhth
      qoyq (66)
      padx (45) -> pbga, havc, qoyq
      tknk (41) -> ugml, padx, fwft
      jptl (61)
      ugml (68) -> gyxo, ebii, jptl
      gyxo (61)
      cntj (57)"
    end

    # test "part2" do
    #   assert part2("0 2 7 0") == 4
    #   assert part2(input("test/input/day_06.txt")) == 2793
    # end

    # test "parse" do
    #   assert parse(input("test/input/day_06.txt")) == [11, 11, 13, 7, 0, 15, 5, 5, 4, 4, 1, 1, 7, 1, 15, 11]
    # end

    # test "largest bank" do
    #   assert largest_bank([5, 2, 8, 8, 8]) == {8, 2}
    #   assert largest_bank([11, 11, 13, 7, 0, 15, 5, 5, 4, 4, 1, 1, 7, 1, 15, 11]) == {15, 5}
    # end

    # test "redistribute" do
    #   assert redistribute([0, 2, 7, 0]) == [2, 4, 1, 2]
    #   assert redistribute([2, 4, 1, 2]) == [3, 1, 2, 3]
    #   assert redistribute([3, 1, 2, 3]) == [0, 2, 3, 4]
    #   assert redistribute([0, 2, 3, 4]) == [1, 3, 4, 1]
    #   assert redistribute([1, 3, 4, 1]) == [2, 4, 1, 2]
    # end
end