defmodule Day01 do
  @doc """
  Find the amount of fueld required for part 1

  ## Examples

    iex> Day01.part1("12")
    2

    iex> Day01.part1("14")
    2

    iex> Day01.part1("1969")
    654

    iex> Day01.part1("100756")
    33583

    iex> Helpers.input("day_01") |> Day01.part1
    3_391_707
  """
  def part1(input) do
    input
    |> Helpers.parse_to_integer_list("\n")
    |> Enum.map(&required_fuel/1)
    |> Enum.sum()
  end

  @doc """
  Find the amount of fuel required for part 2.

  ## Examples

    iex> Day01.part2("14")
    2

    iex> Day01.part2("1969")
    966

    iex> Day01.part2("100756")
    50346

    iex> File.read!("test/input/day_01") |> Day01.part2
    5_084_676
  """
  def part2(input) do
    input
    |> Helpers.parse_to_integer_list("\n")
    |> Enum.map(&total_required_fuel/1)
    |> Enum.sum()
  end

  def required_fuel(mass), do: (div(mass, 3) - 2) |> max(0)

  defp total_required_fuel(mass) when mass <= 0, do: 0

  defp total_required_fuel(mass) do
    fuel = required_fuel(mass)

    fuel + total_required_fuel(fuel)
  end
end
