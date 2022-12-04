defmodule Day04 do
  def part1(input) do
    input
    |> parse()
    |> Enum.count(&fully_contains?/1)
  end

  def part2(input) do
    input
  end

  defp fully_contains?({{a1, a2}, {b1, b2}}) do
    (a1 >= b1 && a2 <= b2) || (b1 >= a1 && b2 <= a2)
  end

  defp parse(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split(",")
      |> Enum.map(fn part ->
        [left, right] = String.split(part, "-")
        {String.to_integer(left), String.to_integer(right)}
      end)
      |> List.to_tuple()
    end)
  end
end
