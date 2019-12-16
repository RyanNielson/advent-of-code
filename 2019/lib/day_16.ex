defmodule Day16 do
  @doc """
  ## Examples
    iex> Day16.part1("80871224585914546619083218645595")
    24176176

    iex> Day16.part1("19617804207202209144916044189917")
    73745418

    iex> Day16.part1("69317163492948606335995924319873")
    52432133

    iex> Helpers.input("day_16") |> Day16.part1()
    67481260
  """
  def part1(input) do
    signal =
      input
      |> parse()

    patterns = patterns(Enum.count(signal))
    run_phases(signal, patterns)
  end

  defp run_phases(signal, patterns) do
    1..100
    |> Enum.reduce(signal, fn _, signal ->
      patterns
      |> Enum.map(fn pattern ->
        signal
        |> Enum.zip(pattern)
        |> Enum.map(fn {a, b} -> a * b end)
        |> Enum.sum()
        |> abs()
        |> rem(10)
      end)
    end)
    |> Enum.take(8)
    |> Enum.join()
    |> String.to_integer()
  end

  # TODO: This is ugly clean it up. ALSO SLOW, maybe use streams.
  defp patterns(length) do
    1..length
    |> Enum.map(fn position ->
      [0, 1, 0, -1]
      |> Enum.flat_map(fn element ->
        1..position
        |> Enum.map(fn _ -> element end)
      end)
      |> List.duplicate(length)
      |> Enum.flat_map(& &1)
      |> Enum.drop(1)
      |> Enum.take(length)
    end)
  end

  def parse(input) do
    input
    |> Helpers.parse_to_integer_list("")
  end
end
