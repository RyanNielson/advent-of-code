defmodule Day07 do
  def part_1(input) do
    input
    |> solve()
    |> elem(1)
  end

  def part_2(input) do
    input
    |> solve()
    |> elem(0)
    |> Map.values()
    |> Enum.sum()
  end

  defp solve(input) do
    rows =
      input
      |> String.split()
      |> Enum.map(&String.graphemes/1)

    start = rows |> hd() |> Enum.find_index(fn x -> x == "S" end)

    rows
    |> tl()
    |> Enum.reduce({Map.new([{start, 1}]), 0}, fn row, {beams, split_count} ->
      if "^" not in row do
        {beams, split_count}
      else
        beams
        |> Enum.reduce({Map.new(), split_count}, fn {beam, timelines},
                                                    {next_beams, new_split_count} ->
          case Enum.at(row, beam) do
            "." ->
              {next_beams |> Map.update(beam, timelines, &(&1 + timelines)), new_split_count}

            "^" ->
              {
                next_beams
                |> Map.update(beam - 1, timelines, &(&1 + timelines))
                |> Map.update(beam + 1, timelines, &(&1 + timelines)),
                new_split_count + 1
              }
          end
        end)
      end
    end)
  end
end
