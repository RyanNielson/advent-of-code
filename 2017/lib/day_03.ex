defmodule AdventOfCode2017.Day03 do
  require Integer

  def part1(input) do
    goal = parse(input)

    goal
    |> side_length
    |> build_movement_instructions(goal)
    |> Enum.reduce({0, 0}, fn({dx, dy}, {x, y}) -> {x + dx, y + dy} end)
    |> calculate_distance
  end

  def part2(input) do
    goal = parse(input)

    goal
    |> side_length
    |> build_movement_instructions(goal)
    |> Enum.map_reduce({0, 0}, fn({dx, dy}, {x, y}) -> {{x + dx, y + dy}, {x + dx, y + dy}} end)
    |> elem(0)
    |> Enum.reduce_while(%{}, &calculate(&1, &2, goal))
  end

  def side_length(value) do
    ceiled_int = value |> :math.sqrt |> Float.ceil |> round

    case Integer.is_even(ceiled_int) do
      true  -> ceiled_int + 1
      false -> ceiled_int
    end
  end

  def build_movement_instructions(1, _), do: [{0, 0}]

  def build_movement_instructions(side_length, goal) do
    build_movement_instructions(side_length - 2, goal)
      ++ [{1, 0}]
      ++ Enum.map(0..(side_length - 3), fn _ -> {0, 1} end)
      ++ Enum.map(0..(side_length - 2), fn _ -> {-1, 0} end)
      ++ Enum.map(0..(side_length - 2), fn _ -> {0, -1} end)
      ++ Enum.map(0..(side_length - 2), fn _ -> {1, 0} end)
    |> Enum.take(goal)
  end

  def calculate_distance({x, y}), do: abs(x) + abs(y)

  defp neighbours({x, y}), do: [{x - 1, y - 1}, {x - 1, y}, {x - 1, y + 1}, {x, y - 1}, {x, y + 1}, {x + 1, y - 1}, {x + 1, y}, {x + 1, y + 1}]

  defp calculate(position = {0, 0}, grid, _goal), do: {:cont, Map.put(grid, position, 1)}

  defp calculate(position, grid, goal) do
    value = position
    |> neighbours
    |> Enum.map(&Map.get(grid, &1, 0))
    |> Enum.sum

    case value > goal do
      true  -> {:halt, value}
      false -> {:cont, Map.put(grid, position, value)}
    end
  end

  defp parse(input), do: input |> String.trim |> String.to_integer
end
