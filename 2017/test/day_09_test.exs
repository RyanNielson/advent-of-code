defmodule AdventOfCode2017.Day09Test do
  use ExUnit.Case

  import AdventOfCode2017.Day09
  import AdventOfCode2017.TestHelper

  test "part1" do
    assert part1(sample_input_1()) == 1
    assert part1(sample_input_2()) == 6
    assert part1(sample_input_3()) == 5
    assert part1(sample_input_4()) == 16
    assert part1(sample_input_5()) == 1
    assert part1(sample_input_6()) == 9
    assert part1(sample_input_7()) == 9
    assert part1(sample_input_8()) == 3
    assert part1(input("test/input/day_09.txt")) == 20530
  end

  test "part2" do
    assert part2(sample_input_1_2()) == 0
    assert part2(sample_input_2_2()) == 17
    assert part2(sample_input_3_2()) == 3
    assert part2(sample_input_4_2()) == 2
    assert part2(sample_input_5_2()) == 0
    assert part2(sample_input_6_2()) == 0
    assert part2(sample_input_7_2()) == 10
    assert part2(input("test/input/day_09.txt")) == 9978
  end

  defp sample_input_1, do: "{}"
  defp sample_input_2, do: "{{{}}}"
  defp sample_input_3, do: "{{},{}}"
  defp sample_input_4, do: "{{{},{},{{}}}}"
  defp sample_input_5, do: "{<a>,<a>,<a>,<a>}"
  defp sample_input_6, do: "{{<ab>},{<ab>},{<ab>},{<ab>}}"
  defp sample_input_7, do: "{{<!!>},{<!!>},{<!!>},{<!!>}}"
  defp sample_input_8, do: "{{<a!>},{<a!>},{<a!>},{<ab>}}"

  defp sample_input_1_2, do: "<>"
  defp sample_input_2_2, do: "<random characters>"
  defp sample_input_3_2, do: "<<<<>"
  defp sample_input_4_2, do: "<{!>}>"
  defp sample_input_5_2, do: "<!!>"
  defp sample_input_6_2, do: "<!!!>>"
  defp sample_input_7_2, do: "<{o\"i!a,<{i<a>"
end