defmodule Day10 do
  def part1(input) do
    register_values = register_values(input)

    19..220//40
    |> Enum.map(&((&1 + 1) * Enum.at(register_values, &1)))
    |> Enum.sum()
  end

  def part2(input) do
    register_values = register_values(input)

    0..239
    |> Enum.map(fn cycle ->
      register = Enum.at(register_values, cycle)
      sprite = [register - 1, register, register + 1]

      if Enum.member?(sprite, Integer.mod(cycle, 40)), do: "#", else: "."
    end)
    |> Enum.chunk_every(40)
    |> Enum.join("\n")
    # Add extra newline to get test to pass since heredoc adds a newline
    |> Kernel.<>("\n")
  end

  defp register_values(input) do
    {register_values, _} =
      input
      |> String.split("\n")
      |> Enum.flat_map_reduce(1, fn instruction, x ->
        register_values = begin_instruction(instruction, x)

        {register_values, List.last(register_values)}
      end)

    [1 | register_values]
  end

  defp begin_instruction("noop", x), do: [x]
  defp begin_instruction("addx " <> value, x), do: [x, x + String.to_integer(value)]
end
