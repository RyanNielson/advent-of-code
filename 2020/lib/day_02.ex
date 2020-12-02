defmodule Day02 do
  @doc """
  Part 1
  Find the number of valid passwords that contain better min and max of the given character.
  """
  def part1(input) do
    input
    |> parse()
    |> Enum.count(fn {min, max, letter, password} ->
      letter_count = Enum.count(String.graphemes(password), fn char -> char == letter end)
      letter_count >= min and letter_count <= max
    end)
  end

  @doc """
  Part 2
  Find the number of valid passwords where the given letter exists at index i or j, but not both.
  """
  def part2(input) do
    input
    |> parse()
    |> Enum.count(fn {i, j, letter, password} ->
      pos_1 = String.at(password, i - 1) == letter
      pos_2 = String.at(password, j - 1) == letter

      (pos_1 || pos_2) && !(pos_1 && pos_2)
    end)
  end

  def parse(input) do
    input
    |> Helpers.parse_to_list("\n")
    |> Enum.map(fn line ->
      [min, max, letter, password] =
        Regex.run(~r/(\d+)-(\d+) (.): (.+)/, line, capture: :all_but_first)

      {String.to_integer(min), String.to_integer(max), letter, password}
    end)
  end
end
