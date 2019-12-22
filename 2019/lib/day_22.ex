defmodule Day22 do
  @doc """
  ## Examples
    # iex> Helpers.input("day_22_example_1") |> Day22.part1(0..9)
    # [0, 3, 6, 9, 2, 5, 8, 1, 4, 7]

    # iex> Helpers.input("day_22_example_2") |> Day22.part1(0..9)
    # [3, 0, 7, 4, 1, 8, 5, 2, 9, 6]

    # iex> Helpers.input("day_22_example_3") |> Day22.part1(0..9)
    # [6, 3, 0, 7, 4, 1, 8, 5, 2, 9]

    # iex> Helpers.input("day_22_example_4") |> Day22.part1(0..9)
    # [9, 2, 5, 8, 1, 4, 7, 0, 3, 6]

    iex> Helpers.input("day_22") |> Day22.part1()
    6289
  """
  def part1(input, deck \\ 0..10006) do
    input
    |> parse()
    |> Enum.reduce(Enum.to_list(deck), &technique/2)
    |> Enum.find_index(&(&1 == 2019))
  end

  defp technique("deal into new stack", deck), do: Enum.reverse(deck)

  defp technique("cut " <> num, deck) do
    {left, right} = Enum.split(deck, String.to_integer(num))
    right ++ left
  end

  defp technique("deal with increment " <> num, deck) do
    increment(deck, String.to_integer(num), Enum.count(deck), 0, %{})
  end

  defp increment([], _, _, _, new_deck) do
    new_deck
    |> Enum.sort()
    |> Enum.map(&elem(&1, 1))
  end

  defp increment([top | rest], num, starting_length, position, new_deck) do
    increment(
      rest,
      num,
      starting_length,
      rem(position + num, starting_length),
      Map.put(new_deck, position, top)
    )
  end

  def parse(input) do
    input
    |> String.split("\n", trim: true)
  end
end
