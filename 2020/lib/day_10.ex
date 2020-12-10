defmodule Day10 do
  def part1(input) do
    %{1 => one_count, 3 => three_count} =
      input
      |> parse()
      |> adapters()
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map(fn [adapter1, adapter2] -> adapter2 - adapter1 end)
      |> Enum.frequencies()

    one_count * three_count
  end

  def part2(input) do
    [_ | adapters_tail] =
      adapters =
      input
      |> parse()
      |> adapters()

    adapters_tail
    |> Enum.reduce(%{0 => 1}, fn adapter, acc ->
      Map.put(
        acc,
        adapter,
        Map.get(acc, adapter - 1, 0) + Map.get(acc, adapter - 2, 0) + Map.get(acc, adapter - 3, 0)
      )
    end)
    |> Map.get(Enum.max(adapters))
  end

  defp adapters(input_adapters) do
    [0 | input_adapters ++ [Enum.max(input_adapters) + 3]]
  end

  defp parse(input) do
    input
    |> Helpers.parse_to_list("\n")
    |> Enum.map(&String.to_integer/1)
    |> Enum.sort()
  end
end
