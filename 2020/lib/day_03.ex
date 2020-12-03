defmodule Day03 do
  def part1(input) do
    input
    |> parse()
    |> toboggan_run({3, 1})
  end

  def part2(input) do
    data =
      input
      |> parse()

    [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]
    |> Enum.map(&toboggan_run(data, &1))
    |> Enum.reduce(1, &(&1 * &2))
  end

  defp toboggan_run({lines, width}, {x_slope, y_slope}) do
    x_positions = Stream.iterate(0, &rem(&1 + x_slope, width))

    lines
    |> Stream.take_every(y_slope)
    |> Stream.zip(x_positions)
    |> Enum.count(fn {line, x} -> String.at(line, x) == "#" end)
  end

  defp parse(input) do
    [first_line | _] =
      lines =
      input
      |> Helpers.parse_to_list("\n")

    {lines, String.length(first_line)}
  end
end
