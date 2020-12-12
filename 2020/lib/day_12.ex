defmodule Day12 do
  def part1(input) do
    input
    |> parse()
    |> navigate()
    |> manhattan_distance()
  end

  # TODO: Maybe flip ship and direction, and we might be able to share all this code.
  def part2(input) do
    input
    |> parse()
    |> navigate_using_waypoint()
    |> manhattan_distance()

    # |> manhattan_distance()
  end

  defp manhattan_distance({x, y}) do
    abs(x) + abs(y)
  end

  defp navigate(instructions) do
    instructions
    |> Enum.reduce({{0, 0}, {1, 0}}, fn instruction, acc ->
      instruction(instruction, acc)
    end)
    |> elem(0)
  end

  defp instruction({"N", value}, {{x, y}, direction}) do
    {{x, y - value}, direction}
  end

  defp instruction({"S", value}, {{x, y}, direction}) do
    {{x, y + value}, direction}
  end

  defp instruction({"E", value}, {{x, y}, direction}) do
    {{x + value, y}, direction}
  end

  defp instruction({"W", value}, {{x, y}, direction}) do
    {{x - value, y}, direction}
  end

  # TODO: Clean turn instructions up because they're basically the same.
  defp instruction({"L", value}, {position, direction}) do
    times = div(value, 90)

    new_direction =
      0..(times - 1)
      |> Enum.reduce(direction, fn _, {dx, dy} ->
        {dy, -dx}
      end)

    {position, new_direction}
  end

  defp instruction({"R", value}, {position, direction}) do
    times = div(value, 90)

    new_direction =
      0..(times - 1)
      |> Enum.reduce(direction, fn _, {dx, dy} ->
        {-dy, dx}
      end)

    {position, new_direction}
  end

  defp instruction({"F", value}, {{x, y}, {dx, dy} = direction}) do
    {{x + dx * value, y + dy * value}, direction}
  end

  defp navigate_using_waypoint(instructions) do
    instructions
    |> Enum.reduce({{0, 0}, {10, -1}}, fn instruction, acc ->
      instruction_waypoint(instruction, acc)
    end)
    |> elem(0)
  end

  defp instruction_waypoint({"N", value}, {ship, {wx, wy}}) do
    {ship, {wx, wy - value}}
  end

  defp instruction_waypoint({"S", value}, {ship, {wx, wy}}) do
    {ship, {wx, wy + value}}
  end

  defp instruction_waypoint({"E", value}, {ship, {wx, wy}}) do
    {ship, {wx + value, wy}}
  end

  defp instruction_waypoint({"W", value}, {ship, {wx, wy}}) do
    {ship, {wx - value, wy}}
  end

  # TODO: Clean turn instructions up because they're basically the same.
  defp instruction_waypoint({"L", value}, {position, waypoint}) do
    times = div(value, 90)

    new_waypoint =
      0..(times - 1)
      |> Enum.reduce(waypoint, fn _, {wx, wy} ->
        {wy, -wx}
      end)

    {position, new_waypoint}
  end

  defp instruction_waypoint({"R", value}, {position, waypoint}) do
    times = div(value, 90)

    new_waypoint =
      0..(times - 1)
      |> Enum.reduce(waypoint, fn _, {wx, wy} ->
        {-wy, wx}
      end)

    {position, new_waypoint}
  end

  defp instruction_waypoint({"F", value}, {{x, y}, {wx, wy} = waypoint}) do
    {{x + wx * value, y + wy * value}, waypoint}
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      {action, value} = String.split_at(line, 1)
      {action, String.to_integer(value)}
    end)
  end
end
