defmodule Day14 do
  def part1(input), do: find_solution(input, &fall/2)

  def part2(input), do: find_solution(input, &fall2/2, 2)

  defp find_solution(input, fall_fn, max_offset \\ 0) do
    input |> parse(max_offset) |> simulate(fall_fn) |> Enum.count(fn {_, v} -> v == "o" end)
  end

  defp simulate(cave, fall_fn) do
    case fall_fn.({500, 0}, cave) do
      {:cont, cave} -> simulate(cave, fall_fn)
      {:halt, cave} -> cave
    end
  end

  defp fall({x, y}, cave) do
    cond do
      y >= Map.get(cave, :max_y) -> {:halt, cave}
      !blocked?({x, y + 1}, cave) -> fall({x, y + 1}, cave)
      !blocked?({x - 1, y + 1}, cave) -> fall({x - 1, y + 1}, cave)
      !blocked?({x + 1, y + 1}, cave) -> fall({x + 1, y + 1}, cave)
      true -> {:cont, Map.put(cave, {x, y}, "o")}
    end
  end

  defp fall2({x, y}, cave) do
    cond do
      blocked?({500, 0}, cave) -> {:halt, cave}
      !blocked?({x, y + 1}, cave, true) -> fall2({x, y + 1}, cave)
      !blocked?({x - 1, y + 1}, cave, true) -> fall2({x - 1, y + 1}, cave)
      !blocked?({x + 1, y + 1}, cave, true) -> fall2({x + 1, y + 1}, cave)
      true -> {:cont, Map.put(cave, {x, y}, "o")}
    end
  end

  defp blocked?({_, y} = position, cave, inf_floor \\ false) do
    (inf_floor && y == Map.get(cave, :max_y)) || Map.get(cave, position) == "#" ||
      Map.get(cave, position) == "o"
  end

  defp parse(input, max_offset) do
    cave =
      input
      |> String.split("\n")
      |> Enum.reduce(%{}, fn line, cave ->
        line
        |> String.split(" -> ")
        |> Enum.map(fn coord ->
          coord
          |> String.split(",")
          |> Enum.map(&String.to_integer/1)
          |> List.to_tuple()
        end)
        |> Enum.chunk_every(2, 1, :discard)
        |> Enum.flat_map(fn [{x1, y1}, {x2, y2}] ->
          for x <- x1..x2, y <- y1..y2, do: {x, y}
        end)
        |> Enum.reduce(cave, &Map.put(&2, &1, "#"))
      end)

    cave
    |> Map.put(:max_y, (cave |> Map.keys() |> Enum.map(&elem(&1, 1)) |> Enum.max()) + max_offset)
  end
end
