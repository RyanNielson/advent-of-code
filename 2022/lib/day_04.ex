defmodule Day04 do
  def part1(input) do
    input
    |> parse()
    |> Enum.count(fn {{a1, a2}, {b1, b2}} ->
      (a1 >= b1 && a2 <= b2) || (b1 >= a1 && b2 <= a2)
    end)
  end

  def part2(input) do
    input
    |> parse()
    |> Enum.count(fn {{a1, a2}, {b1, b2}} ->
      (a1 >= b1 && a1 <= b2) || (a2 >= b1 && a2 <= b2) || (b1 >= a1 && b1 <= a2) ||
        (b2 >= a1 && b2 <= a2)
    end)
  end

  defp parse(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      [a, b, c, d] = Regex.run(~r/(\d+)-(\d+),(\d+)-(\d+)/, line, capture: :all_but_first)
      {{String.to_integer(a), String.to_integer(b)}, {String.to_integer(c), String.to_integer(d)}}
    end)
  end
end
