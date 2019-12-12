defmodule Day09 do
  @doc """
  ## Examples
    iex> Helpers.input("day_09") |> Day09.part1()
    2350741403
  """
  def part1(input) do
    input
    |> Helpers.parse_to_integer_list(",")
    |> Intcode.init([1])
    |> Intcode.run()
    |> Intcode.output()
    |> List.first()
  end

  @doc """
  ## Examples
    iex> Helpers.input("day_09") |> Day09.part2()
    53088
  """
  def part2(input) do
    input
    |> Helpers.parse_to_integer_list(",")
    |> Intcode.init([2])
    |> Intcode.run()
    |> Intcode.output()
    |> List.first()
  end
end
