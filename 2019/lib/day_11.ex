defmodule Day11 do
  @doc """
  ## Examples
    iex> Helpers.input("day_11") |> Day11.part1()
    2428
  """
  def part1(input) do
    starting_state =
      input
      |> Helpers.parse_to_integer_list(",")
      |> Intcode.init([])

    starting_info = %{
      state: starting_state,
      direction: {0, 1},
      floor: %{},
      position: {0, 0}
    }

    starting_info
    |> Stream.iterate(&run/1)
    |> Enum.find(fn %{state: %{halted: halted}} -> halted end)
    |> Map.get(:floor)
    |> Enum.count()
  end

  defp run(info) do
    new_state = info.state |> Intcode.run([Map.get(info.floor, info.position, 0)])
    [color, turn] = new_state |> Intcode.output()
    new_state = new_state |> Intcode.clear_output()

    %{info | state: new_state}
    |> paint(color)
    |> rotate(turn)
    |> move()
  end

  defp paint(%{floor: floor, position: position} = info, color) do
    %{info | floor: Map.put(floor, position, color)}
  end

  # defp color(value) do
  #   case value do
  #     0 -> :w
  #     1 -> b
  #   end
  # end

  # Rotate left 0,1 -> -1,0 -> 0,-1 -> 1,0 -> 0,1
  defp rotate(%{direction: {x, y}} = info, 0), do: %{info | direction: {-y, x}}
  # Rotate right 0,1 -> 1,0 -> 0,-1 -> -1,0 -> 0,1
  defp rotate(%{direction: {x, y}} = info, 1), do: %{info | direction: {y, -x}}

  defp move(%{position: {x, y}, direction: {dx, dy}} = info) do
    %{info | position: {x + dx, y + dy}}
  end
end
