defmodule Day18 do
  def part1(input) do
    input
    |> parse()
    |> unconnected_faces()
  end

  defp unconnected_faces(cubes) do
    cubes
    |> Enum.map(fn {x, y, z} ->
      [{1, 0, 0}, {-1, 0, 0}, {0, 1, 0}, {0, -1, 0}, {0, 0, 1}, {0, 0, -1}]
      |> Enum.count(fn {ox, oy, oz} ->
        !MapSet.member?(cubes, {x + ox, y + oy, z + oz})
      end)
    end)
    |> Enum.sum()
  end

  def part2(input) do
    input
  end

  defp parse(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
    end)
    |> MapSet.new()
  end
end
