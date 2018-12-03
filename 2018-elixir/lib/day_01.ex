defmodule AdventOfCode2018.Day01 do
  def part1(input) do
    input
    |> split_numbers()
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> split_numbers()
    |> Stream.cycle()
    |> Enum.reduce_while({0, MapSet.new()}, fn num, {current, frequencies_reached} ->
      if MapSet.member?(frequencies_reached, current) do
        {:halt, current}
      else
        {:cont, {current + num, MapSet.put(frequencies_reached, current)}}
      end
    end)
  end

  defp split_numbers(input) do
    input
    |> String.split([",", " ", "\n"], trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end