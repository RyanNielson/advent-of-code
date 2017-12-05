defmodule AdventOfCode2017.Day05 do
  def part1(input) do
    input
    |> parse()
    |> jump_around(&(&1 + 1))
  end

  def part2(input) do
    input
    |> parse()
    |> jump_around(&(if &1 >= 3, do: &1 - 1, else: &1 + 1))
  end

  defp jump_around(offsets, new_offset_fn, position \\ 0, steps \\ 0)

  defp jump_around(offsets, _, position, steps) when position >= map_size(offsets) do
    steps
  end

  defp jump_around(offsets, new_offset_fn, position, steps) do
    offset = offsets[position]

    jump_around(
      Map.put(offsets, position, new_offset_fn.(offset)),
      new_offset_fn,
      position + offset,
      steps + 1
    )
  end

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index()
    |> Enum.into(%{}, fn {value, index} -> {index, value} end)
  end
end