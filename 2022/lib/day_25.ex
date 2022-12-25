defmodule Day25 do
  def part1(input) do
    input
    |> parse()
    |> Enum.map(&to_decimal/1)
    |> Enum.sum()
    |> to_snafu()
  end

  def to_decimal(snafu) do
    snafu
    |> Enum.map(fn
      {"=", amount} -> -2 * amount
      {"-", amount} -> -1 * amount
      {digit, amount} -> String.to_integer(digit) * amount
    end)
    |> Enum.sum()
  end

  defp to_snafu(decimal) do
    Stream.iterate(0, &(&1 + 1))
    |> Enum.reduce_while({[], decimal}, fn _, {snafu, number} ->
      division = div(number, 5)
      remainder = rem(number, 5)

      {division, digit} =
        case remainder do
          n when n in [0, 1, 2] -> {division, n}
          3 -> {division + 1, "="}
          4 -> {division + 1, "-"}
        end

      if number == 0, do: {:halt, snafu}, else: {:cont, {[digit | snafu], division}}
    end)
    |> Enum.join()
  end

  def part2(input) do
    input
  end

  defp parse(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split("", trim: true)
      |> Enum.reverse()
      |> Enum.with_index(fn element, i ->
        {element, 5 ** i}
      end)
    end)
  end
end
