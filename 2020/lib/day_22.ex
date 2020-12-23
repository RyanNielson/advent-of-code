defmodule Day22 do
  def part1(input) do
    [player1, player2] =
      input
      |> parse()

    play(player1, player2)
    |> score()
  end

  def part2(input) do
    [player1, player2] =
      input
      |> parse()

    {_, deck} = play_recursive(player1, player2, [])
    score(deck)
  end

  defp play(player1, []), do: player1
  defp play([], player2), do: player2

  defp play([card1 | rest1], [card2 | rest2]) do
    cond do
      card1 > card2 -> play(rest1 ++ [card1, card2], rest2)
      card2 > card1 -> play(rest1, rest2 ++ [card2, card1])
    end
  end

  defp play_recursive(player1, [], _), do: {:p1, player1}
  defp play_recursive([], player2, _), do: {:p2, player2}

  defp play_recursive([card1 | rest1] = deck1, [card2 | rest2] = deck2, history) do
    cond do
      Enum.member?(history, {deck1, deck2}) ->
        {:p1, deck1}

      Enum.count(rest1) >= card1 && Enum.count(rest2) >= card2 ->
        slice1 = Enum.slice(rest1, 0, card1)
        slice2 = Enum.slice(rest2, 0, card2)
        {winner, _} = play_recursive(slice1, slice2, [])

        case winner do
          :p1 -> play_recursive(rest1 ++ [card1, card2], rest2, history ++ [{deck1, deck2}])
          :p2 -> play_recursive(rest1, rest2 ++ [card2, card1], history ++ [{deck1, deck2}])
        end

      card1 > card2 ->
        play_recursive(rest1 ++ [card1, card2], rest2, history ++ [{deck1, deck2}])

      card2 > card1 ->
        play_recursive(rest1, rest2 ++ [card2, card1], history ++ [{deck1, deck2}])
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
