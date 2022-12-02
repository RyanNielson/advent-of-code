defmodule Day02 do
  def part1(input) do
    input
    |> parse()
    |> Enum.map(&convert_move/1)
    |> Enum.map(&round_score/1)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> parse()
    |> Enum.map(&determine_move/1)
    |> Enum.map(&round_score/1)
    |> Enum.sum()
  end

  defp convert_move({opponent, "X"}), do: {opponent, "A"}
  defp convert_move({opponent, "Y"}), do: {opponent, "B"}
  defp convert_move({opponent, "Z"}), do: {opponent, "C"}

  defp determine_move({"A", "X"}), do: {"A", "C"}
  defp determine_move({"B", "X"}), do: {"B", "A"}
  defp determine_move({"C", "X"}), do: {"C", "B"}
  defp determine_move({"A", "Z"}), do: {"A", "B"}
  defp determine_move({"B", "Z"}), do: {"B", "C"}
  defp determine_move({"C", "Z"}), do: {"C", "A"}
  defp determine_move({opponent, "Y"}), do: {opponent, opponent}

  defp round_score({opponent, me}), do: shape_score(me) + outcome_score(opponent, me)

  defp shape_score("A"), do: 1
  defp shape_score("B"), do: 2
  defp shape_score("C"), do: 3

  defp outcome_score("A", "B"), do: 6
  defp outcome_score("B", "C"), do: 6
  defp outcome_score("C", "A"), do: 6
  defp outcome_score("A", "C"), do: 0
  defp outcome_score("B", "A"), do: 0
  defp outcome_score("C", "B"), do: 0
  defp outcome_score(_, _), do: 3

  defp parse(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split()
      |> List.to_tuple()
    end)
  end
end
