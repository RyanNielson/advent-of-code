defmodule Day08 do
  @doc """
  ## Examples
    iex> Helpers.input("day_08") |> Day08.part1(25, 6)
    2500
  """
  def part1(input, width, height) do
    target_layer =
      input
      |> layers(width, height)
      |> Enum.min_by(fn layer ->
        layer |> Enum.filter(&(&1 == 0)) |> Enum.count()
      end)

    Enum.count(target_layer, &(&1 == 1)) * Enum.count(target_layer, &(&1 == 2))
  end

  @doc """
  Prints the message stored in the input. In this case CYUAH should be output.

  ## Examples
    iex> Helpers.input("day_08") |> Day08.part2(25, 6)
    ["0110010001100100110010010", "1001010001100101001010010", "1000001010100101001011110", "1000000100100101111010010", "1001000100100101001010010", "0110000100011001001010010"]
  """
  def part2(input, width, height) do
    input
    |> layers(width, height)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(fn pixel_values ->
      Enum.find(pixel_values, fn pixel -> pixel == 0 or pixel == 1 end)
    end)
    |> Enum.chunk_every(width)
    |> Enum.map(&Enum.join/1)
  end

  defp layers(input, width, height) do
    input
    |> Helpers.parse_to_integer_list("")
    |> Enum.chunk_every(width * height)
  end
end
