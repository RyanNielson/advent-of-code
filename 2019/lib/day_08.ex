defmodule Day08 do
  @doc """
  ## Examples
    iex> Helpers.input("day_08") |> Day08.part1(25, 6)
    2500
  """
  def part1(input, width, height) do
    selected_layer =
      input
      |> parse()
      |> Enum.chunk_every(width * height)
      |> Enum.min_by(fn layer ->
        layer |> Enum.filter(&(&1 == 0)) |> Enum.count()
      end)

    one_digits_count =
      selected_layer
      |> Enum.filter(&(&1 == 1))
      |> Enum.count()

    two_digits_count =
      selected_layer
      |> Enum.filter(&(&1 == 2))
      |> Enum.count()

    one_digits_count * two_digits_count
  end

  defp parse(input) do
    input
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
