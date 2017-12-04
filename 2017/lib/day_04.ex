defmodule AdventOfCode2017.Day04 do
  def part1(input) do
    input
    |> parse
    |> Enum.count(&no_duplicates?/1)
  end

  def part2(input) do
    input
    |> parse
    |> Enum.count(&no_anagrams?/1)
  end

  def no_duplicates?(passphrase) do
    passphrase
    |> Enum.uniq
    |> Kernel.==(passphrase)
  end

  def no_anagrams?(passphrase) do
    sorted_words = passphrase
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&Enum.sort/1)

    Enum.uniq(sorted_words) == sorted_words
  end

  defp parse(input) do
    input
    |> String.trim
    |> String.split("\n")
    |> Enum.map(&String.split/1)
  end
end