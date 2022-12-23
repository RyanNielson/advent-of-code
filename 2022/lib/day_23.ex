defmodule Day23 do
  def part1(input) do
    elves =
      input
      |> parse()

    {moved_elves, _} =
      0..9
      |> Enum.reduce({elves, ["N", "S", "W", "E"]}, fn _, {elves, directions} ->
        proposals =
          elves
          |> Enum.filter(&has_adjacent_elf?(&1, elves))
          |> Enum.map(fn elf ->
            {elf, propose_move(elf, elves, directions)}
          end)
          |> Enum.reject(fn {_, proposal} -> is_nil(proposal) end)

        new_elves =
          proposals
          |> Enum.reject(fn {elf, proposal} ->
            Enum.any?(proposals, fn {other_elf, other_proposal} ->
              elf != other_elf && proposal == other_proposal
            end)
          end)
          |> Enum.reduce(elves, fn {elf, proposal}, elves ->
            elves
            |> MapSet.delete(elf)
            |> MapSet.put(proposal)
          end)

        [first | rest] = directions

        {new_elves, rest ++ [first]}
      end)

    {{min_x, _}, {max_x, _}} = Enum.min_max_by(moved_elves, fn {x, _} -> x end)
    {{_, min_y}, {_, max_y}} = Enum.min_max_by(moved_elves, fn {_, y} -> y end)

    positions = for x <- min_x..max_x, y <- min_y..max_y, do: {x, y}

    positions
    |> Enum.count(&(!MapSet.member?(moved_elves, &1)))
  end

  defp propose_move({x, y}, elves, directions) do
    direction_to_move =
      directions
      |> Enum.find(fn
        "N" ->
          !Enum.any?([{x, y - 1}, {x + 1, y - 1}, {x - 1, y - 1}], fn position ->
            MapSet.member?(elves, position)
          end)

        "S" ->
          !Enum.any?([{x, y + 1}, {x + 1, y + 1}, {x - 1, y + 1}], fn position ->
            MapSet.member?(elves, position)
          end)

        "W" ->
          !Enum.any?([{x - 1, y}, {x - 1, y + 1}, {x - 1, y - 1}], fn position ->
            MapSet.member?(elves, position)
          end)

        "E" ->
          !Enum.any?([{x + 1, y}, {x + 1, y + 1}, {x + 1, y - 1}], fn position ->
            MapSet.member?(elves, position)
          end)
      end)

    case direction_to_move do
      "N" -> {x, y - 1}
      "S" -> {x, y + 1}
      "W" -> {x - 1, y}
      "E" -> {x + 1, y}
      nil -> nil
    end
  end

  defp has_adjacent_elf?({x, y}, elves) do
    [
      {x + 1, y},
      {x - 1, y},
      {x, y + 1},
      {x, y - 1},
      {x + 1, y + 1},
      {x + 1, y - 1},
      {x - 1, y + 1},
      {x - 1, y - 1}
    ]
    |> Enum.any?(fn position ->
      MapSet.member?(elves, position)
    end)
  end

  def part2(input) do
    input
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, y} ->
      line
      |> String.codepoints()
      |> Enum.with_index()
      |> Enum.filter(fn {cell, _} -> cell == "#" end)
      |> Enum.map(fn {_, x} -> {x, y} end)
    end)
    |> MapSet.new()
  end
end
