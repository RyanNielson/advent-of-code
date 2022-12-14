defmodule Day14 do
  def part1(input) do
    {cave, max_y} =
      input
      |> parse()

    cave
    |> simulate(max_y, &fall/3)
    |> Enum.count(fn {_k, v} -> v == "o" end)
  end

  def part2(input) do
    {cave, max_y} =
      input
      |> parse()

    cave
    |> simulate(max_y + 2, &fall2/3)
    |> Enum.count(fn {_, v} -> v == "o" end)
  end

  defp simulate(cave, max_y, fall_fn) do
    Stream.iterate(0, &(&1 + 1))
    |> Enum.reduce_while(cave, fn _i, cave ->
      fall_fn.({500, 0}, cave, max_y)
    end)
  end

  defp fall({sx, sy}, cave, max_y) do
    cond do
      sy >= max_y -> {:halt, cave}
      !blocked?({sx, sy + 1}, cave) -> fall({sx, sy + 1}, cave, max_y)
      !blocked?({sx - 1, sy + 1}, cave) -> fall({sx - 1, sy + 1}, cave, max_y)
      !blocked?({sx + 1, sy + 1}, cave) -> fall({sx + 1, sy + 1}, cave, max_y)
      true -> {:cont, Map.put(cave, {sx, sy}, "o")}
    end
  end

  defp blocked?(position, cave) do
    Map.get(cave, position) == "#" || Map.get(cave, position) == "o"
  end

  defp fall2({sx, sy}, cave, max_y) do
    cond do
      blocked2?({500, 0}, cave, max_y) -> {:halt, cave}
      !blocked2?({sx, sy + 1}, cave, max_y) -> fall2({sx, sy + 1}, cave, max_y)
      !blocked2?({sx - 1, sy + 1}, cave, max_y) -> fall2({sx - 1, sy + 1}, cave, max_y)
      !blocked2?({sx + 1, sy + 1}, cave, max_y) -> fall2({sx + 1, sy + 1}, cave, max_y)
      true -> {:cont, Map.put(cave, {sx, sy}, "o")}
    end
  end

  defp blocked2?({_x, y} = position, cave, max_y) do
    y == max_y || Map.get(cave, position) == "#" || Map.get(cave, position) == "o"
  end

  defp parse(input) do
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

    {cave, cave |> Map.keys() |> Enum.map(&elem(&1, 1)) |> Enum.max()}
  end
end