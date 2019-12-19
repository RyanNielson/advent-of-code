defmodule Day18 do
  @doc """
  ## Examples
    iex> Helpers.input("day_18") |> Day18.part1()
    223
  """
  def part1(input, width \\ 50, height \\ 50) do
    input
    |> parse()
    |> points(width, height)
    |> Map.values()
    |> Enum.count(& &1)
  end

  # This can just return a list, no need for the coordinates other than debugging.
  defp points(program, width, height) do
    for x <- 0..(width - 1), y <- 0..(height - 1), into: %{} do
      output =
        program
        |> Intcode.init([y, x])
        |> Intcode.run()
        |> Intcode.output()
        |> List.first()

      value =
        case output do
          0 -> false
          1 -> true
        end

      {{x, y}, value}
    end
  end

  def parse(input) do
    input
    |> Helpers.parse_to_integer_list(",")
  end
end
