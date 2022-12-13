defmodule Day13 do
  def part1(input) do
    input
    |> parse()
    |> Enum.chunk_every(2)
    |> Enum.map(fn [packet1, packet2] -> compare(packet1, packet2) end)
    |> Enum.with_index(1)
    |> Enum.filter(fn {comparison, _} -> comparison == -1 end)
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> parse()
    |> Kernel.++([[[2]], [[6]]])
    |> Enum.sort(fn a, b -> compare(a, b) <= 0 end)
    |> Enum.with_index(1)
    |> Enum.filter(fn {packet, _} -> packet == [[2]] || packet == [[6]] end)
    |> Enum.map(&elem(&1, 1))
    |> Enum.product()
  end

  defp compare([_ | _], []), do: 1
  defp compare([], [_ | _]), do: -1
  defp compare([], []), do: 0

  defp compare([a | resta], [b | restb]) do
    result = compare(a, b)
    if result == 0, do: compare(resta, restb), else: result
  end

  defp compare(a, b) when is_list(a), do: compare(a, [b])
  defp compare(a, b) when is_list(b), do: compare([a], b)

  defp compare(a, b) do
    cond do
      a < b -> -1
      a > b -> 1
      true -> 0
    end
  end

  defp parse(input) do
    input
    |> String.split("\n")
    |> Enum.map(&(Code.eval_string(&1) |> elem(0)))
    |> Enum.reject(&is_nil/1)
  end
end
