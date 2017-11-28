defmodule Day06 do
  def run(input, most_common? \\ true) do
    input
    |> parse
    |> index_characters(%{})
    |> generate_message("", most_common?)
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

  def generate_message([{_index, chars} | rest], message, most_common?) do
    new_character = chars
    |> Enum.group_by(&(&1))
    |> Enum.map(fn {a, b} -> {a, String.length(to_string(b))} end)
    |> sort_characters(most_common?)
    |> hd
    |> elem(0)

    generate_message(rest, message <> new_character, most_common?)
  end

  def generate_message([], message, _), do: message

  def sort_characters(chars, most_common?) when most_common?, do: chars |> Enum.sort_by(fn {_char, count} -> -count end)
  def sort_characters(chars, _), do: chars |> Enum.sort_by(fn {_char, count} -> count end)
end
