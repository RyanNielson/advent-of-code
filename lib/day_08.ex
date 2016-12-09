defmodule Day08 do
  def run(input, width, height) do
    input
    |> parse
    |> Enum.reduce(generate_screen(width, height), &command/2)
    |> count
  end

  def command(["rect", x, y], screen), do: for i <- 0..(x - 1), j <- 0..(y - 1), into: screen, do: {{i, j}, "#"}

  def command(["rotate", "column", x, amount], screen) do
    new_column = screen
    |> get_column(x)
    |> rotate(amount)
    |> Enum.into(%{}, fn {char, y} -> {{x,y}, char} end)

    Map.merge(screen, new_column)
  end

  def command(["rotate", "row", y, amount], screen) do
    new_row = screen
    |> get_row(y)
    |> rotate(amount)
    |> Enum.into(%{}, fn {char, x} -> {{x,y}, char} end)

    Map.merge(screen, new_row)
  end

  def get_column(screen, column), do: Enum.filter(screen, &match?({{^column, _}, _}, &1)) |> content

  def get_row(screen, row), do: Enum.filter(screen, &match?({{_, ^row}, _}, &1)) |> content

  def content(screen_part), do: screen_part |> Enum.sort |> Enum.map(&elem(&1, 1))

  def rotate(contents, amount), do: (Enum.take(contents, -amount) ++ Enum.drop(contents, -amount)) |> Enum.with_index

  def count(screen), do: screen |> Enum.count(&match?({_, "#"}, &1))

  def generate_screen(width, height), do: for x <- 0..width-1, y <- 0..height-1, into: %{}, do: {{x, y}, "."}

  def parse(input) do
    input
    |> String.trim
    |> String.split("\n", trim: true)
    |> Enum.map(&Day08.parse_command/1)
  end

  def parse_command("rect" <> _options = command) do
    command
    |> String.split([" ", "x"])
    |> prepare_rect_options
  end

  def parse_command("rotate" <> _options = command) do
    command
    |> String.split([" ", "=", "by"], trim: true)
    |> prepare_rotate_options
  end

  def prepare_rect_options([command, x, y]), do: [command, String.to_integer(x), String.to_integer(y)]
  def prepare_rotate_options([command, column_or_row, _, field, amount]), do: [command, column_or_row, String.to_integer(field), String.to_integer(amount)]
end
