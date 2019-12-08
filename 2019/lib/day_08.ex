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
    :ok
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
    |> Enum.each(&IO.puts/1)
  end

  defp layers(input, width, height) do
    input
    |> parse()
    |> Enum.chunk_every(width * height)
  end

  defp parse(input) do
    input
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
