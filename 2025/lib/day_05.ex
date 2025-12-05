defmodule Day05 do
  @spec part_1(any()) :: none()
  def part_1(input) do
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

    available
    |> Enum.map(&String.to_integer/1)
    |> Enum.count(fn ingredient ->
      Enum.any?(ranges, fn range -> ingredient in range end)
    end)
  end

  def part_2(input) do
    input
  end
end
