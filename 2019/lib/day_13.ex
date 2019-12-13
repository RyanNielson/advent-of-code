defmodule Day13 do
  @doc """
  ## Examples
    iex> Helpers.input("day_13") |> Day13.part1()
    361
  """
  def part1(input) do
    %{grid: grid} =
      input
      |> prepare_game()

    grid
    |> Map.values()
    |> Enum.count(&(&1 == 2))
  end

  @doc """
  ## Examples
    iex> Helpers.input("day_13") |> Day13.part2()
    17590
  """
  def part2(input) do
    %{grid: grid} =
      input
      |> prepare_game()
      |> play()

    grid |> Map.get({-1, 0})
  end

  def prepare_game(input) do
    state =
      input
      |> Helpers.parse_to_integer_list(",")
      |> List.replace_at(0, 2)
      |> Intcode.init()
      |> Intcode.run()

    %{
      state: state,
      grid: build_grid(Intcode.output(state))
    }
  end

  def play(%{state: state} = game) do
    game = update_grid(game)

    case Intcode.halted?(state) do
      true -> game
      false -> next_turn(game)
    end
  end

  def next_turn(%{state: state} = game) do
    play(%{game | state: Intcode.run(state, joystick_direction(game))})
  end

  def joystick_direction(game) do
    {{px, _}, _} = game |> find_tile(3)
    {{bx, _}, _} = game |> find_tile(4)

    cond do
      px < bx -> 1
      px == bx -> 0
      px > bx -> -1
    end
  end

  defp find_tile(%{grid: grid}, id), do: grid |> Enum.find(fn {_, tile_id} -> tile_id == id end)

  defp build_grid(output, grid \\ %{}) do
    output
    |> Enum.chunk_every(3)
    |> Enum.into(grid, fn [x, y, id] -> {{x, y}, id} end)
  end

  defp update_grid(%{state: state, grid: grid}) do
    {state, output} = Intcode.pop_output(state)

    %{state: state, grid: build_grid(output, grid)}
  end
end
