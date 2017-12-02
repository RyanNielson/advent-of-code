defmodule AdventOfCode2017.Day02Test do
  use ExUnit.Case

  import AdventOfCode2017.Day02
  import AdventOfCode2017.TestHelper

  describe "Part 1" do
    test "part1" do
      assert part1(input_sample_1()) == 18
      assert part1(input_sample_2()) == 72
      assert part1(input("test/input/day_02.txt")) == 45158
    end
  
    defp input_sample_1, do: "5 1 9 5\n7 5 3\n2 4 6 8"
    defp input_sample_2, do: "12 8 4 1\n1 62 5"
  end

  describe "Part 2" do
    test "part2" do
      assert part2(input_sample_1_2()) == 9
      assert part2(input("test/input/day_02.txt")) == 294
    end

    test "get_row_divided" do
      assert get_row_divided([5, 9, 2, 8]) == 4
    end

    defp input_sample_1_2, do: "5 9 2 8\n9 4 7 3\n3 8 6 5"
  end
end