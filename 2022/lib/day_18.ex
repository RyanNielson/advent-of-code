defmodule Day18 do
  def part1(input) do
    input
    |> parse()
    |> count_faces(false)
  end

  def part2(input) do
    cubes =
      input
      |> parse()

    {{min_x, _, _}, {max_x, _, _}} = Enum.min_max_by(cubes, &elem(&1, 0))
    {{_, min_y, _}, {_, max_y, _}} = Enum.min_max_by(cubes, &elem(&1, 1))
    {{_, _, min_z}, {_, _, max_z}} = Enum.min_max_by(cubes, &elem(&1, 2))

    initial_edge_positions =
      for x <- (min_x - 1)..(max_x + 1),
          y <- (min_y - 1)..(max_y + 1),
          z <- (min_z - 1)..(max_z + 1),
          x == min_x - 1 || x == max_x + 1 || y == min_y - 1 || y == max_y + 1 || z == min_z - 1 ||
            z == max_z + 1,
          into: MapSet.new(),
          do: {x, y, z}

    cubes
    |> edge_cubes(initial_edge_positions, {{min_x, min_y, min_z}, {max_x, max_y, max_z}})
    |> count_faces(true, cubes)
  end

  defp edge_cubes(_, edges, {{min_x, min_y, min_z}, {max_x, max_y, max_z}})
       when min_x > max_x or min_y > max_y or min_z > max_z do
    edges
  end

  defp edge_cubes(cubes, edges, {{min_x, min_y, min_z}, {max_x, max_y, max_z}}) do
    empty_edge_positions =
      for x <- min_x..max_x,
          y <- min_y..max_y,
          z <- min_z..max_z,
          (x == min_x || x == max_x || y == min_y || y == max_y || z == min_z || z == max_z) &&
            !MapSet.member?(cubes, {x, y, z}),
          into: MapSet.new(),
          do: {x, y, z}

    new_edges = next_edges(empty_edge_positions, edges)

    case Enum.empty?(new_edges) do
      true ->
        edges

      false ->
        edge_cubes(
          cubes,
          MapSet.union(edges, new_edges),
          {{min_x + 1, min_y + 1, min_z + 1}, {max_x - 1, max_y - 1, max_z - 1}}
        )
    end
  end

  defp next_edges(empty_edge_positions, edges) do
    {new_edges, leftovers} =
      empty_edge_positions
      |> Enum.split_with(fn {x, y, z} ->
        [{1, 0, 0}, {-1, 0, 0}, {0, 1, 0}, {0, -1, 0}, {0, 0, 1}, {0, 0, -1}]
        |> Enum.any?(fn {ox, oy, oz} ->
          MapSet.member?(edges, {x + ox, y + oy, z + oz})
        end)
      end)
      |> then(fn {new_edges, leftovers} -> {MapSet.new(new_edges), MapSet.new(leftovers)} end)

    case !Enum.empty?(new_edges) && !Enum.empty?(leftovers) do
      true -> next_edges(leftovers, MapSet.union(edges, new_edges))
      false -> MapSet.union(edges, new_edges)
    end
  end

  defp count_faces(cubes, connected?), do: count_faces(cubes, connected?, cubes)

  defp count_faces(cubes, connected?, all_cubes) do
    cubes
    |> Enum.map(fn {x, y, z} ->
      [{1, 0, 0}, {-1, 0, 0}, {0, 1, 0}, {0, -1, 0}, {0, 0, 1}, {0, 0, -1}]
      |> Enum.count(fn {ox, oy, oz} ->
        if connected?,
          do: MapSet.member?(all_cubes, {x + ox, y + oy, z + oz}),
          else: !MapSet.member?(all_cubes, {x + ox, y + oy, z + oz})
      end)
    end)
    |> Enum.sum()
  end

  defp parse(input) do
    input
    |> String.split("\n")
    |> Enum.into(MapSet.new(), fn line ->
      line
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
    end)
  end
end
