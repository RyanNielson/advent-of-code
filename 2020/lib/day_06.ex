defmodule Day06 do
  # Part 1 and part 2 could probably both be consolidated to use MapSet.
  def part1(input) do
    input
    |> parse()
    |> Enum.map(&String.replace(&1, "\n", ""))
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&Enum.uniq/1)
    |> List.flatten()
    |> Enum.count()
  end

  def part2(input) do
    input
    |> parse()
    |> Enum.map(fn groups ->
      groups
      |> String.split("\n")
      |> Enum.map(&(String.graphemes(&1) |> MapSet.new()))
      |> Enum.reduce(&MapSet.intersection(&1, &2))
      |> Enum.count()
    end)
    |> Enum.sum()
  end

  defp parse(input) do
    input
    |> Helpers.parse_to_list("\n\n")
  end
end
