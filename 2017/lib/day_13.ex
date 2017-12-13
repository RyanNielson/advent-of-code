defmodule AdventOfCode2017.Day13 do
  def part1(input) do
    input |> parse() |> Enum.filter(&caught?(&1, 0)) |> severity_sum()
  end

  def part2(input) do
    input |> parse() |> determine_delay()
  end

  defp severity_sum(layers_caught) do
    layers_caught |> Enum.map(fn {layer, depth} -> layer * depth end) |> Enum.sum()
  end

  defp determine_delay(layers, delay \\ 0) do
    case Enum.any?(layers, &caught?(&1, delay)) do
      true  -> determine_delay(layers, delay + 1)
      false -> delay
    end
  end

  defp caught?({layer, depth}, delay), do: rem(layer + delay, depth + depth - 2) == 0

  def parse(input), do: input |> String.split("\n", trim: true) |> Enum.map(&parse_row/1)

  defp parse_row(row), do: row |> String.split(": ") |> Enum.map(&String.to_integer/1) |> List.to_tuple()
end