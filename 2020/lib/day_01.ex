defmodule Day01 do
  @doc """
  Part 1
  Find the two entries that sum to 2020 and multiply them together.
  """
  def part1(input) do
    numbers = parse_numbers(input)
    result = for i <- numbers, j <- numbers, i + j == 2020, do: i * j
    hd(result)
  end

  @doc """
  Part 2
  Find the three entries that sum to 2020 and multiply them together.
  """
  def part2(input) do
    numbers = parse_numbers(input)
    result = for i <- numbers, j <- numbers, k <- numbers, i + j + k == 2020, do: i * j * k
    hd(result)
  end

  def parse_numbers(input) do
    input |> Helpers.parse_to_integer_list("\n")
  end
end
