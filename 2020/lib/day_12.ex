defmodule Day12 do
  def part1(input) do
    input
    |> parse()
    |> navigate({{0, 0}, {1, 0}}, &instruction/2)
    |> manhattan_distance()
  end

  def part2(input) do
    input
    |> parse()
    |> navigate({{0, 0}, {10, -1}}, &instruction_waypoint/2)
    |> manhattan_distance()
  end

  defp navigate(instructions, start, instruction_handler) do
    instructions
    |> Enum.reduce(start, &instruction_handler.(&1, &2))
    |> elem(0)
  end

  defp instruction({"N", value}, {{x, y}, direction}), do: {{x, y - value}, direction}
  defp instruction({"S", value}, {{x, y}, direction}), do: {{x, y + value}, direction}
  defp instruction({"E", value}, {{x, y}, direction}), do: {{x + value, y}, direction}
  defp instruction({"W", value}, {{x, y}, direction}), do: {{x - value, y}, direction}

  defp instruction({"F", value}, {{x, y}, {dx, dy} = direction}),
    do: {{x + dx * value, y + dy * value}, direction}

  defp instruction({action, value}, {position, direction}),
    do: {position, turn(action, value, direction)}

  defp instruction_waypoint({"N", value}, {ship, {wx, wy}}), do: {ship, {wx, wy - value}}
  defp instruction_waypoint({"S", value}, {ship, {wx, wy}}), do: {ship, {wx, wy + value}}
  defp instruction_waypoint({"E", value}, {ship, {wx, wy}}), do: {ship, {wx + value, wy}}
  defp instruction_waypoint({"W", value}, {ship, {wx, wy}}), do: {ship, {wx - value, wy}}

  defp instruction_waypoint({"F", value}, {{x, y}, {wx, wy} = waypoint}),
    do: {{x + wx * value, y + wy * value}, waypoint}

  defp instruction_waypoint({action, value}, {position, waypoint}),
    do: {position, turn(action, value, waypoint)}

  defp turn(action, value, direction) do
    0..(div(value, 90) - 1)
    |> Enum.reduce(direction, fn _, {wx, wy} ->
      case action do
        "L" -> {wy, -wx}
        "R" -> {-wy, wx}
      end
    end)
  end

  defp manhattan_distance({x, y}), do: abs(x) + abs(y)

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      {action, value} = String.split_at(line, 1)
      {action, String.to_integer(value)}
    end)
  end
end
