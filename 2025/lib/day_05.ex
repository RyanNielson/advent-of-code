defmodule Day05 do
  def part_1(input) do
    {ranges, available} =
      input
      |> parse()

    available
    |> Enum.map(&String.to_integer/1)
    |> Enum.count(fn ingredient ->
      Enum.any?(ranges, fn range -> ingredient in range end)
    end)
  end

  def part_2(input) do
    input
    |> parse()
    |> elem(0)
    |> Enum.map(&Range.size/1)
    |> Enum.sum()
  end

  defp parse(input) do
    {ranges, available} =
      input
      |> String.split("\n\n")
      |> Enum.map(&String.split(&1, "\n"))
      |> List.to_tuple()

    ranges =
      ranges
      |> Enum.map(fn range ->
        [start, finish] = range |> String.split("-") |> Enum.map(&String.to_integer/1)
        start..finish
      end)
      |> simplify_ranges()

    {ranges, available}
  end

  defp simplify_ranges(ranges) do
    ranges
    |> Enum.sort_by(& &1.first)
    |> Enum.reduce([], fn range, acc ->
      case acc do
        [] ->
          [range]

        [prev | rest] ->
          # If ranges overlap or touch merge them
          if range.first <= prev.last + 1,
            do: [prev.first..max(prev.last, range.last) | rest],
            else: [range | acc]
      end
    end)
  end
end
