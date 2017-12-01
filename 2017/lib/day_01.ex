defmodule AdventOfCode2017.Day01 do
  def run(input) do
    input 
    |> parse_to_circular_list
    |> combine_like_values
    |> sum
  end

  def parse_to_circular_list(input) do
    first = input |> String.first
    input 
    |> Kernel.<>(first)
    |> String.graphemes
    |> Enum.map(&String.to_integer/1)
  end

  def combine_like_values(circular_list) do
    circular_list
    |> Enum.chunk_by(&(&1))
  end

  def sum(grouped_list) do
    grouped_list
    |> Enum.reduce(0, fn([num | rest], acc) -> acc + num * length(rest) end)
  end
end