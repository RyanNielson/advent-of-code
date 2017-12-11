defmodule AdventOfCode2017.Day11 do
  def part1(input) do
    input
    |> parse()
    |> move()
    |> List.first()
  end

  def part2(input) do
    input
    |> parse()
    |> move()
    |> Enum.max()
  end

  def move(steps), do: move(steps, {0, 0, 0}, [])
  def move(["n" | rest],  {x, y, z} = coords, dists), do: move(rest, {x, y + 1, z - 1}, [hex_distance(coords) | dists])
  def move(["ne" | rest], {x, y, z} = coords, dists), do: move(rest, {x + 1, y, z - 1}, [hex_distance(coords) | dists])
  def move(["se" | rest], {x, y, z} = coords, dists), do: move(rest, {x + 1, y - 1, z}, [hex_distance(coords) | dists])
  def move(["s" | rest],  {x, y, z} = coords, dists), do: move(rest, {x, y - 1, z + 1}, [hex_distance(coords) | dists])
  def move(["sw" | rest], {x, y, z} = coords, dists), do: move(rest, {x - 1, y, z + 1}, [hex_distance(coords) | dists])
  def move(["nw" | rest], {x, y, z} = coords, dists), do: move(rest, {x - 1, y + 1, z}, [hex_distance(coords) | dists])
  def move([], coords, dists), do: [hex_distance(coords) | dists]

  def hex_distance({x, y, z}), do: div(abs(x) + abs(y) + abs(z), 2)

  def parse(input), do: String.split(input, ",", trim: true)
end