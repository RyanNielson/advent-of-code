defmodule Day11 do
  @doc """
  ## Examples
    iex> Helpers.input("day_11") |> Day11.part1()
    2428
  """
  def part1(input) do
    input
    |> Helpers.parse_to_integer_list(",")
    |> Intcode.init([])
    |> prepare_and_run()
    |> Map.get(:floor)
    |> Enum.count()
  end

  @doc """
  ## Examples
    iex> Helpers.input("day_11") |> Day11.part2()
    ["0111000011010000111101110010010011001001000", "0100100001010000100001001010010100101001000", "0100100001010000111001110010010100001001000", "0111000001010000100001001010010100001001000", "0101001001010000100001001010010100101001000", "0100100110011110100001110001100011000110000"]
  """
  def part2(input) do
    input
    |> Helpers.parse_to_integer_list(",")
    |> Intcode.init([])
    |> prepare_and_run(%{{0, 0} => 1})
    |> draw()
  end

  defp draw(%{floor: floor}) do
    {min_x, _} = floor |> Map.keys() |> Enum.min_by(fn {x, _} -> x end)
    {max_x, _} = floor |> Map.keys() |> Enum.max_by(fn {x, _} -> x end)
    {_, min_y} = floor |> Map.keys() |> Enum.min_by(fn {_, y} -> y end)
    {_, max_y} = floor |> Map.keys() |> Enum.max_by(fn {_, y} -> y end)

    max_y..min_y
    |> Enum.map(fn y ->
      min_x..max_x
      |> Enum.map(fn x ->
        Map.get(floor, {x, y}, 0)
      end)
      |> Enum.join()
    end)
  end

  defp prepare_and_run(starting_state, starting_floor \\ %{}) do
    starting_info = %{
      state: starting_state,
      direction: {0, 1},
      floor: starting_floor,
      position: {0, 0}
    }

    starting_info
    |> Stream.iterate(&run/1)
    |> Enum.find(fn %{state: %{halted: halted}} -> halted end)
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

  defp paint(%{floor: floor, position: position} = info, color),
    do: %{info | floor: Map.put(floor, position, color)}

  # Rotate left 0,1 -> -1,0 -> 0,-1 -> 1,0 -> 0,1
  defp rotate(%{direction: {x, y}} = info, 0), do: %{info | direction: {-y, x}}
  # Rotate right 0,1 -> 1,0 -> 0,-1 -> -1,0 -> 0,1
  defp rotate(%{direction: {x, y}} = info, 1), do: %{info | direction: {y, -x}}

  defp move(%{position: {x, y}, direction: {dx, dy}} = info),
    do: %{info | position: {x + dx, y + dy}}
end
