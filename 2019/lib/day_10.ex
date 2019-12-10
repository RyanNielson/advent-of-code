defmodule Day10 do
  @doc """
  ## Examples
    iex> Helpers.input("day_10_example_1") |> Day10.part1()
    8

    iex> Helpers.input("day_10_example_2") |> Day10.part1()
    33

    iex> Helpers.input("day_10_example_3") |> Day10.part1()
    35

    iex> Helpers.input("day_10_example_4") |> Day10.part1()
    41

    iex> Helpers.input("day_10_example_5") |> Day10.part1()
    210

    iex> Helpers.input("day_10") |> Day10.part1()
    319
  """
  def part1(input) do
    asteroids =
      input
      |> parse()

    asteroids
    |> Enum.map(&count_asteroids(&1, asteroids))
    |> Enum.max()
  end

  @doc """
  ## Examples
    iex> Helpers.input("day_10_2_example_1") |> Day10.part2()
    1403

    iex> Helpers.input("day_10_example_5") |> Day10.part2()
    802

    iex> Helpers.input("day_10") |> Day10.part2()
    517
  """
  def part2(input) do
    asteroids = input |> parse()
    station = asteroids |> Enum.max_by(&count_asteroids(&1, asteroids))

    sorted_asteroids =
      asteroids
      |> asteroids_by_angle(station)
      |> asteroids_with_angles(station)
      |> Enum.sort_by(fn {_, angle, i} -> {i, -angle} end)
      |> Enum.map(&elem(&1, 0))

    {x, y} = sorted_asteroids |> Enum.at(199, List.last(sorted_asteroids))

    x * 100 + y
  end

  defp other_asteroids(asteroids, start), do: for(a <- asteroids, a != start, do: a)

  defp count_asteroids(start, asteroids) do
    asteroids
    |> asteroids_by_angle(start)
    |> Enum.count()
  end

  defp asteroids_by_angle(asteroids, {x1, y1} = start) do
    asteroids
    |> other_asteroids(start)
    |> Enum.group_by(fn {x2, y2} -> :math.atan2(x2 - x1, y2 - y1) end)
  end

  defp asteroids_with_angles(asteroid_angle_groups, start) do
    asteroid_angle_groups
    |> Enum.flat_map(fn {angle, asteroids} ->
      asteroids
      |> Enum.sort_by(&distance(start, &1))
      |> Enum.with_index()
      |> Enum.map(fn {asteroid, i} -> {asteroid, angle, i} end)
    end)
  end

  defp distance({x1, y1}, {x2, y2}), do: :math.sqrt(:math.pow(x2 - x1, 2) + :math.pow(y2 - y1, 2))

  defp parse(input) do
    for {row, y} <- input |> String.split("\n", trim: true) |> Enum.with_index(),
        {val, x} <- row |> String.codepoints() |> Enum.with_index(),
        val == "#",
        do: {x, y}
  end
end
