defmodule Day18 do
  @doc """
  ## Examples
    # iex> Helpers.input("day_18") |> Day18.part1()
    # 223
  """
  def part1(input) do
    input
    |> parse()
    |> points(50, 50)
    |> Map.values()
    |> Enum.count(& &1)
  end

  @doc """
  ## Examples
    iex> Helpers.input("day_18") |> Day18.part2()
    9480761
  """
  def part2(input) do
    state =
      input
      |> parse()
      |> Intcode.init()

    {start_x, start_y} =
      for(x <- 50..99, y <- 50..99, do: {x, y})
      |> Enum.filter(fn {x, y} -> check_point(x, y, state) end)
      |> Enum.max()

    {x, y} = find_square(state, start_x, start_y)

    x * 10000 + y
  end


  # This can just return a list, no need for the coordinates other than debugging.
  defp points(program, width, height) do
    state = program |> Intcode.init()

    for x <- 0..(width - 1), y <- 0..(height - 1), into: %{} do
      {{x, y}, check_point(x, y, state)}
    end
  end

  # 100 or 99 >=?
  defp find_square(state, x, y) do
    if check_point(x, y, state) do
      if check_point(x + 99, y - 99, state), do: {x, y - 99}, else: find_square(state, x, y + 1)
    else
      find_square(state, x + 1, y)
    end
  end

  def check_point(x, y, state) do
    output =
      state
      |> Intcode.run([x, y])
      |> Intcode.output()
      |> List.first()

    case output do
      0 -> false
      1 -> true
    end
  end

  def parse(input) do
    input
    |> Helpers.parse_to_integer_list(",")
  end
end
