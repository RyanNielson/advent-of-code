defmodule Day07 do
  def part_1(input) do
    rows =
      input
      |> String.split()
      |> Enum.map(&String.graphemes/1)

    start = rows |> hd() |> Enum.find_index(fn x -> x == "S" end)
    starting_beams = MapSet.new([start])

    rows
    |> tl()
    |> Enum.reduce({starting_beams, 0}, fn row, {beams, split_count} ->
      if "^" not in row do
        {beams, split_count}
      else
        beams
        |> Enum.reduce({MapSet.new(), split_count}, fn beam, {next_beams, new_split_count} ->
          case row |> Enum.at(beam) do
            "." ->
              {next_beams |> MapSet.put(beam), new_split_count}

            "^" ->
              {next_beams |> MapSet.put(beam - 1) |> MapSet.put(beam + 1), new_split_count + 1}
          end
        end)
      end
    end)
    |> elem(1)
  end

  def part_2(input) do
    input
  end
end
