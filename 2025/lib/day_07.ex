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
    rows =
      input
      |> String.split()
      |> Enum.map(&String.graphemes/1)

    start = rows |> hd() |> Enum.find_index(fn x -> x == "S" end)
    starting_beams = Map.new([{start, 1}])

    rows
    |> tl()
    |> Enum.reduce({starting_beams, 0}, fn row, {beams, split_count} ->
      {row, beams, split_count} |> dbg()

      if "^" not in row do
        {beams, split_count}
      else
        beams
        |> Enum.reduce({Map.new(), split_count}, fn {beam, timelines},
                                                    {next_beams, new_split_count} ->
          {beam, timelines, row} |> dbg()

          case Enum.at(row, beam) do
            "." ->
              {next_beams |> Map.update(beam, timelines, fn existing -> existing + timelines end),
               new_split_count}

            "^" ->
              {
                next_beams
                |> Map.update(beam - 1, timelines, fn existing -> existing + timelines end)
                |> Map.update(beam + 1, timelines, fn existing -> existing + timelines end),
                new_split_count + 1
              }
          end
        end)
      end
    end)
    |> elem(0)
    |> Map.values()
    |> Enum.sum()
  end
end
