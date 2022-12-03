defmodule Day03 do
  def part1(input) do
    input
    |> parse()
    |> Enum.map(fn line ->
      {compartment1, compartment2} = Enum.split(line, div(Enum.count(line), 2))
      {MapSet.new(compartment1), MapSet.new(compartment2)}
    end)
    |> Enum.map(&intersection/1)
    |> Enum.map(&priority/1)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> parse()
    |> Enum.map(&MapSet.new/1)
    |> Enum.chunk_every(3)
    |> Enum.map(&intersection/1)
    |> Enum.map(&priority/1)
    |> Enum.sum()
  end

  defp intersection({compartment1, compartment2}) do
    compartment1
    |> MapSet.intersection(compartment2)
    |> Enum.at(0)
  end

  defp intersection([line1, line2, line3]) do
    line1
    |> MapSet.intersection(line2)
    |> MapSet.intersection(line3)
    |> Enum.at(0)
  end

  defp priority(<<item_type_num>> = item_type) do
    if String.upcase(item_type) == item_type,
      do: item_type_num - ?A + 27,
      else: item_type_num - ?a + 1
  end

  defp parse(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.graphemes/1)
  end
end
