defmodule Day06 do
  def run(input) do
    input
    |> parse
    |> index_characters(%{})
    |> generate_message("")
  end

  def parse(input) do
    input
    |> String.trim
    |> String.split("\n", trim: true)
  end

  def index_characters([line | lines], grouped) do
    new_grouped = line
    |> String.graphemes
    |> Enum.with_index
    |> Enum.reduce(grouped, fn {char, pos}, updated_grouped ->
      Map.update(updated_grouped, pos, [char], &([char | &1]))
    end)

    index_characters(lines, new_grouped)
  end

  def index_characters([], counts), do: counts |> Map.to_list

  def generate_message([{_index, chars} | rest], message) do
    new_character = chars
    |> Enum.group_by(&(&1))
    |> Enum.map(fn {a, b} -> {a, String.length(to_string(b))} end)
    |> Enum.sort(&Day06.letter_sorter/2)
    |> hd
    |> elem(0)

    generate_message(rest, message <> new_character)
  end

  def generate_message([], message), do: message

  def letter_sorter({a_char, a_count}, {b_char, b_count}) when a_count == b_count, do: a_char <= b_char
  def letter_sorter({_, a_count}, {_, b_count}), do: b_count <= a_count
end
