defmodule AdventOfCode2017.Day01Test do
  use ExUnit.Case

  import AdventOfCode2017.Day01
  import AdventOfCode2017.TestHelper

  describe "Part 1" do
    test "part1" do
        assert part1(input_sample_1()) == 3
        assert part1(input_sample_2()) == 4
        assert part1(input_sample_3()) == 0
        assert part1(input_sample_4()) == 9
        assert part1(input("test/input/day_01.txt")) == 1144
    end
  
    defp input_sample_1, do: "1122"
    defp input_sample_2, do: "1111"
    defp input_sample_3, do: "1234"
    defp input_sample_4, do: "91212129"
  end

  describe "Part 2" do
    test "part2" do
      assert part2(input_sample_1_2()) == 6
      assert part2(input_sample_2_2()) == 0
      assert part2(input_sample_3_2()) == 4
      assert part2(input_sample_4_2()) == 12
      assert part2(input_sample_5_2()) == 4
      assert part2(input("test/input/day_01.txt")) == 1194
    end

    defp input_sample_1_2, do: "1212"
    defp input_sample_2_2, do: "1221"
    defp input_sample_3_2, do: "123425"
    defp input_sample_4_2, do: "123123"
    defp input_sample_5_2, do: "12131415"
  end
end