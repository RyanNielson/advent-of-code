defmodule AdventOfCode2017.Day01Test do
  use ExUnit.Case

  import AdventOfCode2017.Day01
  import AdventOfCode2017.TestHelper

  test "run" do
      assert run(input_sample_1()) == 3
      assert run(input_sample_2()) == 4
      assert run(input_sample_3()) == 0
      assert run(input_sample_4()) == 9
      assert run(input("test/input/day_01.txt")) == 1144
  end
 
  test "parse input into circular list" do
    assert parse_to_circular_list(input_sample_1()) == input_sample_1_circular_list()
    assert parse_to_circular_list(input_sample_2()) == input_sample_2_circular_list()
    assert parse_to_circular_list(input_sample_3()) == input_sample_3_circular_list()
    assert parse_to_circular_list(input_sample_4()) == input_sample_4_circular_list()
  end

  test "combine like values" do
    assert combine_like_values(input_sample_1_circular_list()) == [[1, 1], [2, 2], [1]]
    assert combine_like_values(input_sample_2_circular_list()) == [[1, 1, 1, 1, 1]]
    assert combine_like_values(input_sample_3_circular_list()) == [[1], [2], [3], [4], [1]]
    assert combine_like_values(input_sample_4_circular_list()) == [[9], [1], [2], [1], [2], [1], [2], [9, 9]]
  end

  defp input_sample_1, do: "1122"
  defp input_sample_2, do: "1111"
  defp input_sample_3, do: "1234"
  defp input_sample_4, do: "91212129"

  defp input_sample_1_circular_list, do: [1, 1, 2, 2, 1]
  defp input_sample_2_circular_list, do: [1, 1, 1, 1, 1]
  defp input_sample_3_circular_list, do: [1, 2, 3, 4, 1]
  defp input_sample_4_circular_list, do: [9, 1, 2, 1, 2, 1, 2, 9, 9]
end