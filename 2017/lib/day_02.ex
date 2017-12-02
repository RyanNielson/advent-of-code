defmodule AdventOfCode2017.Day02 do
  def part1(input) do
    input
    |> parse()
    |> Enum.map(&get_row_difference/1)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> parse()
    |> Enum.map(&get_row_divided/1)
    |> Enum.sum()
  end

  def parse(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.split/1)
    |> Enum.map(fn s ->
      Enum.map(s, &String.to_integer/1)
    end)
  end

  def get_row_difference(row), do: Enum.max(row) - Enum.min(row)

  def get_row_divided(row), do: hd(for x <- row, y <- row, x != y, rem(x, y) == 0, do: div(x, y))
end