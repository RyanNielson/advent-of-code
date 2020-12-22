defmodule Day22 do
  def part1(input) do
    [player1, player2] =
      input
      |> parse()

    # Can probably list pipe into this using some functional programming thing.
    play(player1, player2)
    |> score()
  end

  defp play([], player2), do: player2
  defp play(player1, []), do: player1

  defp play([card1 | rest1], [card2 | rest2]) do
    cond do
      card1 > card2 -> play(rest1 ++ [card1, card2], rest2)
      card2 > card1 -> play(rest1, rest2 ++ [card2, card1])
    end
  end

  defp score(deck) do
    deck
    |> Enum.reverse()
    |> Enum.with_index(1)
    |> Enum.map(fn {card, value} -> card * value end)
    |> Enum.sum()
  end

  defp parse(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(fn player ->
      player
      |> String.split("\n")
      |> tl()
      |> Enum.map(&String.to_integer/1)
    end)
  end
end
