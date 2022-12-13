defmodule Day12 do
  def part1(input) do
    {heightmap, start, goal} = parse(input)

    search([{start, 0}], heightmap, goal, MapSet.new([start]))
  end

  def part2(input) do
    {heightmap, _, goal} = parse(input)

    heightmap
    |> Map.filter(fn {_, height} -> height == 0 end)
    |> Map.keys()
    |> Enum.map(&search([{&1, 0}], heightmap, goal, MapSet.new([&1])))
    |> Enum.min()
  end

  defp search([], _, _, _), do: 999_999_999
  defp search([{position, steps} | _], _, goal, _) when position == goal, do: steps

  defp search([{position, steps} | rest], heightmap, goal, explored) do
    adjacent =
      position
      |> adjacent(explored, heightmap)
      |> Enum.map(&{&1, steps + 1})

    search(
      rest ++ adjacent,
      heightmap,
      goal,
      MapSet.union(explored, MapSet.new(Enum.map(adjacent, &elem(&1, 0))))
    )
  end

  defp adjacent({x, y} = v, explored, heightmap) do
    [{x - 1, y}, {x + 1, y}, {x, y - 1}, {x, y + 1}]
    |> Enum.filter(fn position ->
      height = Map.get(heightmap, position)
      v_height = Map.get(heightmap, v)
      !MapSet.member?(explored, position) && height != nil && height - 1 <= v_height
    end)
  end

  defp parse(input) do
    {heightmap, {s, e}} =
      input
      |> String.split("\n")
      |> Enum.with_index()
      |> Enum.flat_map_reduce({{0, 0}, {0, 0}}, fn {line, y}, positions ->
        line
        |> String.to_charlist()
        |> Enum.with_index()
        |> Enum.map_reduce(positions, fn
          {?S, x}, positions -> {{{x, y}, ?a - ?a}, put_elem(positions, 0, {x, y})}
          {?E, x}, positions -> {{{x, y}, ?z - ?a}, put_elem(positions, 1, {x, y})}
          {char, x}, positions -> {{{x, y}, char - ?a}, positions}
        end)
      end)

    {Map.new(heightmap), s, e}
  end
end
