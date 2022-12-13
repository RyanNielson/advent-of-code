defmodule Day13 do
  def part1(input) do
    input
    |> parse()
    |> Enum.map(fn {packet1, packet2} -> compare(packet1, packet2) end)
    |> Enum.with_index(1)
    |> Enum.filter(fn {comparison, _} -> comparison == -1 end)
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> parse()

    # |> Kernel.++([{[[2]], [[6]]}])
    # |>
    # |> Enum.map(fn {packet1, packet2} -> compare(packet1, packet2) end)
    # |> IO.inspect(charlists: :as_lists)
  end

  defp compare([_ | _], []) do
    1
  end

  defp compare([], [_ | _]) do
    -1
  end

  defp compare([], []) do
    0
  end

  # when is_list(a) and is_list(b) do
  defp compare([a | resta], [b | restb]) do
    result = compare(a, b)
    if result == 0, do: compare(resta, restb), else: result
  end

  defp compare(a, b) when is_list(a) do
    compare(a, [b])
  end

  defp compare(a, b) when is_list(b) do
    compare([a], b)
  end

  defp compare(a, b) do
    cond do
      a < b -> -1
      a > b -> 1
      true -> 0
    end
  end

  defp parse(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(fn pair ->
      pair
      |> String.split("\n")
      |> Enum.map(&(Code.eval_string(&1) |> elem(0)))
      |> List.to_tuple()
    end)
  end
end
