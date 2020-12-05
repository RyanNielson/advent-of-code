defmodule Day05 do
  def part1(input) do
    input
    |> parse()
    |> seat_ids()
    |> Enum.max()
  end

  def part2(input) do
    seat_ids =
      input
      |> parse()
      |> seat_ids()

    {min_seat_id, max_seat_id} = Enum.min_max(seat_ids)

    (Enum.to_list(min_seat_id..max_seat_id) -- seat_ids) |> List.first()
  end

  defp seat_ids(seats) do
    seats
    |> Enum.map(fn seat ->
      seat
      |> String.replace("F", "0")
      |> String.replace("B", "1")
      |> String.replace("L", "0")
      |> String.replace("R", "1")
      |> String.to_integer(2)
    end)
  end

  defp parse(input) do
    input |> Helpers.parse_to_list("\n")
  end
end
