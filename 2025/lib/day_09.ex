defmodule Day09 do
  def part_1(input) do
    positions =
      input
      |> String.split()
      |> Enum.map(fn line ->
        line |> String.split(",") |> Enum.map(&String.to_integer/1) |> List.to_tuple()
      end)

    pairs =
      for p1 <- positions,
          p2 <- positions,
          p1 != p2 do
        {p1, p2}
      end

    pairs
    |> Enum.map(fn {{x1, y1}, {x2, y2}} ->
      (abs(x2 - x1) + 1) * (abs(y2 - y1) + 1)
    end)
    |> Enum.max()
  end

  def part_2(input) do
    input
  end
end
