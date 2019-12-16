defmodule Day16 do
  @doc """
  ## Examples
    # iex> Day16.part1("12345678")
    # 1

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

  @doc """
  ## Examples
    # iex> Day16.part2("03036732577212944063491565474664")
    # 84462026

    # iex> Day16.part2("02935109699940807407585447034323")
    # 78725270

    # iex> Day16.part2("03081770884921959731165446850517")
    # 53553731

    # iex> Helpers.input("day_16") |> Day16.part1()
    # 67481260
  """
  def part2(input) do
    signal =
      input
      |> String.duplicate(10_000)
      |> parse()

    offset =
      signal
      |> Enum.take(7)
      |> Enum.join()
      |> String.to_integer()

    # Could optimize this by skipping the calculations for x first items in a line since they'll all multiply by 0.
    # There's basically a triangle of zeroes which I can skip.
    # Digit 0: no skip
    # Digit 1: 1 skips
    # Digit 2: 2 skips
    # IO.inspect(offset)
    # IO.inspect(signal)

    # patterns = patterns(Enum.count(signal))
    # run_phases(signal, patterns)

    1..100
  end

  defp run_phases(signal, patterns) do
    1..100
    |> Enum.reduce(signal, fn _, signal ->
      patterns
      |> Enum.map(fn pattern ->
        # Trim length of signal to length of -pattern
        signal
        |> Enum.take(-Enum.count(pattern))
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

  defp patterns(length) do
    1..length
    |> Enum.map(fn position ->
      [0, 1, 0, -1]
      |> Stream.cycle()
      |> Stream.flat_map(fn item ->
        Stream.repeatedly(fn -> item end) |> Stream.take(position)
      end)
      |> Enum.take(length + 1)
      |> Enum.drop(1)
      |> Enum.drop_while(fn x -> x == 0 end)
    end)
  end

  def parse(input) do
    input
    |> Helpers.parse_to_integer_list("")
  end
end
