defmodule Day04 do
  @doc """
  ## Examples

    iex> Helpers.input("day_04") |> Day04.part1()
    1169
  """
  def part1(input) do
    input
    |> parse()
    |> Enum.filter(&(adjacent_digits?(&1) and increasing_digits?(&1)))
    |> Enum.count()
  end

  @doc """
  ## Examples

    iex> Helpers.input("day_04") |> Day04.part2()
    757
  """
  def part2(input) do
    input
    |> parse()
    |> Enum.filter(&(adjacent_digits_strict?(&1) and increasing_digits?(&1)))
    |> Enum.count()
  end

  defp adjacent_digits?(number) do
    number
    |> Integer.to_string()
    |> String.match?(~r/(\d)\1/)
  end

  defp adjacent_digits_strict?(number) do
    number
    |> Integer.to_string()
    |> String.split("", trim: true)
    |> adjacent_valid?()
  end

  defp adjacent_valid?([a, b, c, d, e, f]) do
    (a == b and b != c) or
    (a != b and b == c and c != d) or
    (b != c and c == d and d != e) or
    (c != d and d == e and e != f) or
    (d != e and e == f)
  end

  defp increasing_digits?(number) do
    number
    |> Integer.to_string()
    |> String.split("", trim: true)
    |> Enum.sort()
    |> Enum.join()
    |> String.to_integer()
    |> Kernel.==(number)
  end

  defp parse(input) do
    [start, finish] =
      input
      |> String.split("-", trim: true)
      |> Enum.map(&String.to_integer/1)

    start..finish
  end
end
