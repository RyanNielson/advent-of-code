defmodule Day24 do
  def part1(input) do
    {obstacles, wind, start, goal, min_x, max_x, min_y, max_y} =
      input
      |> parse()

    {_, _, steps} = travel(obstacles, wind, start, goal, min_x, max_x, min_y, max_y)

    steps
  end

  def part2(input) do
    {obstacles, wind, start, goal, min_x, max_x, min_y, max_y} =
      input
      |> parse()

    {obstacles, wind, steps1} = travel(obstacles, wind, start, goal, min_x, max_x, min_y, max_y)
    {obstacles, wind, steps2} = travel(obstacles, wind, goal, start, min_x, max_x, min_y, max_y)
    {_, _, steps3} = travel(obstacles, wind, start, goal, min_x, max_x, min_y, max_y)

    steps1 + steps2 + steps3
  end

  defp travel(obstacles, wind, start, goal, min_x, max_x, min_y, max_y) do
    Stream.iterate(0, &(&1 + 1))
    |> Enum.reduce_while({[start], obstacles, wind}, fn step, {positions, obstacles, wind} ->
      obstacles = remove_wind_from_obstacles(obstacles, wind)
      wind = move_wind(wind, min_x, max_x, min_y, max_y)
      obstacles = add_wind_to_obstacles(obstacles, wind)

      positions =
        positions
        |> Enum.flat_map(fn {x, y} ->
          [{0, -1}, {0, 1}, {-1, 0}, {1, 0}, {0, 0}]
          |> Enum.reject(fn {ox, oy} ->
            MapSet.member?(obstacles, {x + ox, y + oy}) || y + oy < min_y || y + oy > max_x
          end)
          |> Enum.map(fn {ox, oy} -> {x + ox, y + oy} end)
        end)
        |> Enum.uniq()

      if Enum.any?(positions, fn position -> position == goal end),
        do: {:halt, {obstacles, wind, step + 1}},
        else: {:cont, {positions, obstacles, wind}}
    end)
  end

  defp remove_wind_from_obstacles(obstacles, wind) do
    Enum.reduce(wind, obstacles, fn {_cell, position}, obstacles ->
      MapSet.delete(obstacles, position)
    end)
  end

  defp move_wind(wind, min_x, max_x, min_y, max_y) do
    Enum.map(wind, fn {cell, {x, y}} ->
      {ox, oy} =
        case cell do
          "^" -> {0, -1}
          "v" -> {0, 1}
          "<" -> {-1, 0}
          ">" -> {1, 0}
        end

      {nx, ny} = new_position = {x + ox, y + oy}

      case cell do
        "^" when ny == min_y -> {cell, {nx, max_y - 1}}
        "v" when ny == max_y -> {cell, {nx, min_y + 1}}
        "<" when nx == min_x -> {cell, {max_x - 1, ny}}
        ">" when nx == max_x -> {cell, {min_x + 1, ny}}
        _ -> {cell, new_position}
      end

      # case MapSet.member?(obstacles, new_position) do
      #   # WRAP AROUND
      #   true when cell == "^" -> {cell, {nx, max_y - 1}}
      #   true when cell == "v" -> {cell, {nx, min_y + 1}}
      #   true when cell == "<" -> {cell, {max_x - 1, ny}}
      #   true when cell == ">" -> {cell, {min_x + 1, ny}}
      #   false -> {cell, new_position}
      # end
    end)
  end

  defp add_wind_to_obstacles(obstacles, wind) do
    Enum.reduce(wind, obstacles, fn {_, position}, obstacles ->
      MapSet.put(obstacles, position)
    end)
  end

  defp parse(input) do
    cells =
      input
      |> String.split("\n", trim: true)
      |> Enum.with_index()
      |> Enum.flat_map(fn {line, y} ->
        line
        |> String.codepoints()
        |> Enum.with_index()
        |> Enum.map(fn {cell, x} -> {{x, y}, cell} end)
      end)

    {{_, max_y}, _} = cells |> Enum.max_by(fn {{_, y}, _} -> y end)
    {{{min_x, _}, _}, {{max_x, _}, _}} = cells |> Enum.min_max_by(fn {{x, _}, _} -> x end)

    start = cells |> Enum.find(fn {{_x, y}, cell} -> y == 0 && cell == "." end) |> elem(0)
    goal = cells |> Enum.find(fn {{_x, y}, cell} -> y == max_y && cell == "." end) |> elem(0)

    {obstacles, wind} =
      cells
      |> Enum.reduce({MapSet.new(), []}, fn {position, cell}, {obstacles, wind} ->
        obstacles =
          case cell do
            c when c in ["#", "^", "v", "<", ">"] -> MapSet.put(obstacles, position)
            # TODO: Add start to obstacles?
            # _ when position == start -> MapSet.put(obstacles, position)
            _ -> obstacles
          end

        wind =
          case cell do
            c when c in ["^", "v", "<", ">"] -> [{c, position} | wind]
            _ -> wind
          end

        {obstacles, wind}
      end)

    {obstacles, wind, start, goal, min_x, max_x, 0, max_y}
  end
end
