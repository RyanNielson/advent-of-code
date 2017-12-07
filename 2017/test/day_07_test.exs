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
end