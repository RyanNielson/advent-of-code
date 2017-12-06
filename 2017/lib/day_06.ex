defmodule AdventOfCode2017.Day06 do
  def part1(input) do
    input
    |> parse
    |> redistribute_until_repeated
  end

  def part2(input) do
    input
    |> parse
    |> redistribute_with_interations
  end

  def redistribute_until_repeated(banks, history \\ MapSet.new) do
    updated_banks = redistribute(banks)

    case MapSet.member?(history, updated_banks) do
      true -> MapSet.size(history) + 1
      false -> redistribute_until_repeated(updated_banks, MapSet.put(history, updated_banks))
    end
  end

  def redistribute_with_interations(banks, history \\ %{}) do
    updated_banks = redistribute(banks)

    case Map.get(history, updated_banks) do
      nil -> redistribute_with_interations(updated_banks, Map.put(history, updated_banks, map_size(history) + 1))
      iteration -> map_size(history) - iteration + 1
    end
  end

  def redistribute(banks) do
    {blocks, index} = largest_bank(banks)
    banks = List.replace_at(banks, index, 0)

    Enum.reduce(1..blocks, banks, fn (count, updated_banks) ->
      blocks_index = rem(index + count, Enum.count(banks))
      List.update_at(updated_banks, blocks_index, &(&1 + 1))
    end)
  end

  def parse(input) do
    input
    |> String.split
    |> Enum.map(&String.to_integer/1)
  end

  def largest_bank(banks) do
    banks
    |> Enum.with_index
    |> Enum.max_by(fn({blocks, _}) -> blocks end)
  end
end