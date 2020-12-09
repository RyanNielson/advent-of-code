defmodule Day09 do
  def part1(input, preamble_length \\ 25) do
    input
    |> parse()
    |> invalid_number(preamble_length)
  end

  def part2(input, preamble_length \\ 25) do
    numbers =
      input
      |> parse()

    numbers
    |> find_contiguous_numbers(invalid_number(numbers, preamble_length))
    |> Enum.min_max()
    |> Tuple.to_list()
    |> Enum.sum()
  end

  defp find_contiguous_numbers(numbers, invalid_number, set_size \\ 2) do
    contigous_numbers =
      numbers
      |> Enum.chunk_every(set_size, 1)
      |> Enum.find(&(Enum.sum(&1) == invalid_number))

    case contigous_numbers do
      nil -> find_contiguous_numbers(numbers, invalid_number, set_size + 1)
      _ -> contigous_numbers
    end
  end

  defp invalid_number(numbers, preamble_length) do
    numbers
    |> Enum.chunk_every(preamble_length + 1, 1)
    |> Enum.find(fn window ->
      {preamble, [number]} = Enum.split(window, preamble_length)
      result = for i <- preamble, j <- preamble, i != j, i + j == number, do: number
      Enum.count(result) == 0
    end)
    |> List.last()
  end

  defp parse(input) do
    input
    |> Helpers.parse_to_list("\n")
    |> Enum.map(&String.to_integer/1)
  end
end
