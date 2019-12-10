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

  defp parse(input) do
    for {row, y} <- input |> String.split("\n", trim: true) |> Enum.with_index(),
        {val, x} <- row |> String.codepoints() |> Enum.with_index(),
        val == "#",
        do: {x, y}
  end

  defp other_asteroids(asteroids, start) do
    for a <- asteroids, a != start, do: a
  end

  defp count_asteroids({x1, y1} = start, asteroids) do
    asteroids
    |> other_asteroids(start)
    |> Enum.group_by(fn {x2, y2} ->
      :math.atan2(y2 - y1, x2 - x1)
    end)
    |> Enum.count()
  end
end
