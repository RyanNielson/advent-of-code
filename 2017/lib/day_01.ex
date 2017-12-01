defmodule AdventOfCode2017.Day01 do
  def part1(input) do
    input 
    |> parse_to_list
    |> summable_list(1)
    |> Enum.sum
  end

  def part2(input) do
    input 
    |> parse_to_list
    |> summable_list
    |> Enum.sum
  end

  defp parse_to_list(input) do
    input 
    |> String.graphemes
    |> Enum.map(&String.to_integer/1)
  end

  defp summable_list(list, offset) do
    list 
    |> Enum.with_index
    |> Enum.filter(fn({num, index}) -> num == Enum.at(list, wrapped_index(length(list), index + offset)) end)
    |> Enum.map(fn({num, _index}) -> num end)
  end

  defp summable_list(list) do
    offset = list |> length |> div(2)
    list 
    |> summable_list(offset)
  end

  defp wrapped_index(length, index) do
    Kernel.rem(index, length)
  end
end