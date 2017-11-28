defmodule Day04.Room do
  defstruct [name: "", id: 0, checksum: ""]

  def parse(room_code) do
    String.split(room_code, ["-", "[", "]"], trim: true)
    |> Enum.reverse
    |> build_room
  end

  def most_common_5_letters(room) do
    room.name
    |> String.graphemes
    |> Enum.reject(fn x -> x == "-" end)
    |> Enum.group_by(fn x -> x end)
    |> Enum.map(fn {x, y} -> {x, String.length(to_string(y))} end)
    |> Enum.sort(&Day04.Room.letter_sorter/2)
    |> Enum.take(5)
    |> Enum.map(fn {x, _count} -> x end)
    |> Enum.join("")
  end

  def letter_sorter({a_char, a_count}, {b_char, b_count}) do
    if a_count == b_count do
        a_char <= b_char
      else
        b_count <= a_count
      end
  end

  defp build_room([checksum | [id | name_parts]] = _parts) do
    %Day04.Room{name: name_parts |> Enum.reverse |> Enum.join("-"), id: String.to_integer(id), checksum: checksum}
  end
end

defmodule Day04 do
  def run(input) do
    input
    |> Day04.parse
    |> Enum.filter(fn room -> Day04.Room.most_common_5_letters(room) == room.checksum end)
    |> Enum.map(fn room -> room.id end)
    |> Enum.sum
  end

  def parse(input) do
    input
    |> String.trim
    |> String.split("\n", trim: true)
    |> Enum.map(&Day04.Room.parse/1)
  end
end
