defmodule Day08 do
  def part1(input) do
    {trees, max} = parse(input)

    trees
    |> Enum.filter(&visible?(&1, trees, max))
    |> Enum.count()
  end

  def part2(input) do
    {trees, max} = parse(input)

    trees
    |> Enum.map(&score(&1, trees, max))
    |> Enum.max()
  end

  defp visible?({{x, y}, _}, _, {max_x, max_y}) when x == 0 or y == 0 or x == max_x or y == max_y,
    do: true

  defp visible?({{x, y}, height}, trees, {max_x, max_y}) do
    positions_left = for i <- 0..(x - 1), do: {i, y}
    positions_right = for i <- (x + 1)..max_x, do: {i, y}
    positions_up = for i <- 0..(y - 1), do: {x, i}
    positions_down = for i <- (y + 1)..max_y, do: {x, i}

    [positions_left, positions_right, positions_up, positions_down]
    |> Enum.any?(fn positions ->
      Enum.all?(positions, &(Map.get(trees, &1) < height))
    end)
  end

  defp score({{x, y}, _}, _, {max_x, max_y}) when x == 0 or y == 0 or x == max_x or y == max_y,
    do: 0

  defp score({{x, y}, height}, trees, {max_x, max_y}) do
    positions_left = for i <- (x - 1)..0, do: {i, y}
    positions_right = for i <- (x + 1)..max_x, do: {i, y}
    positions_up = for i <- (y - 1)..0, do: {x, i}
    positions_down = for i <- (y + 1)..max_y, do: {x, i}

    [positions_left, positions_right, positions_up, positions_down]
    |> Enum.map(fn positions ->
      visible_positions =
        positions
        |> Enum.take_while(&(Map.get(trees, &1) < height))

      if visible_positions == positions,
        do: Enum.count(visible_positions),
        else: Enum.count(visible_positions) + 1
    end)
    |> Enum.product()
  end

  defp parse(input) do
    trees =
      input
      |> String.split("\n")
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {line, y}, trees ->
        line
        |> String.graphemes()
        |> Enum.map(&String.to_integer/1)
        |> Enum.with_index()
        |> Enum.reduce(trees, fn {height, x}, trees -> Map.put(trees, {x, y}, height) end)
      end)

    max =
      trees
      |> Map.keys()
      |> Enum.max()

    {trees, max}
  end
end
