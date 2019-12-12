defmodule Day12 do
  @doc """
  ## Examples
    iex> Helpers.input("day_12_example_1") |> Day12.part1(10)
    179

    iex> Helpers.input("day_12_example_2") |> Day12.part1(100)
    1940

    iex> Helpers.input("day_12") |> Day12.part1()
    13045
  """
  def part1(input, steps \\ 1000) do
    moons =
      input
      |> parse()
      |> init_planets()

    1..steps
    |> Enum.reduce(moons, fn _, planets ->
      step(planets)
    end)
    |> total_energy()
  end

  @doc """
  ## Examples
    iex> Helpers.input("day_12_example_1") |> Day12.part2()
    2772

    iex> Helpers.input("day_12_example_2") |> Day12.part2()
    4_686_774_924

    iex> Helpers.input("day_12") |> Day12.part2()
    344_724_687_853_944
  """
  def part2(input) do
    input
    |> parse()
    |> init_planets()
    |> find_repeat()
  end

  defp step(planets) do
    planets
    |> apply_gravities()
    |> apply_velocities()
  end

  defp total_energy(planets) do
    planets
    |> Enum.map(fn %{pos: {x, y, z}, vel: {vx, vy, vz}} ->
      (abs(x) + abs(y) + abs(z)) * (abs(vx) + abs(vy) + abs(vz))
    end)
    |> Enum.sum()
  end

  defp find_repeat(moons) do
    0..2 |>
    Task.async_stream(fn i -> find_repeat_single(moons, i) end, [timeout: :infinity])
    |> Enum.map(fn {:ok, num} -> num end)
    |> Enum.reduce(fn num, acc -> lcm(acc, num) end)
  end

  defp find_repeat_single(moons, i, history \\ MapSet.new()) do
    new_moons = moons |> step()

    new_history_item =
      new_moons
      |> Enum.map(fn %{pos: pos, vel: vel} -> [elem(pos, i), elem(vel, i)] end)

    case MapSet.member?(history, new_history_item) do
      true -> Enum.count(history)
      false -> find_repeat_single(new_moons, i, MapSet.put(history, new_history_item))
    end
  end


  defp apply_velocities(planets) do
    planets
    |> Enum.map(fn %{pos: {x, y, z}, vel: {vx, vy, vz}} ->
      %{pos: {x + vx, y + vy, z + vz}, vel: {vx, vy, vz}}
    end)
  end

  defp apply_gravities(planets) do
    planets
    |> Enum.map(fn planet1 ->
        new_velocity = planets
        |> Enum.reduce(planet1.vel, fn planet2, {vx, vy, vz} ->
          {x1, y1, z1} = planet1.pos
          {x2, y2, z2} = planet2.pos

          {
            vx + gravity_strength(x1, x2),
            vy + gravity_strength(y1, y2),
            vz + gravity_strength(z1, z2)
          }
        end)

        %{planet1 | vel: new_velocity}
      end)
  end

  defp gravity_strength(a, b) do
    cond do
      a > b -> -1
      a == b -> 0
      a < b -> 1
    end
  end

  defp lcm(a, b), do: div(abs(a * b), Integer.gcd(a, b))

  def init_planets(positions) do
    positions
    |> Enum.map(&%{pos: &1, vel: {0, 0, 0}})
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      Regex.scan(~r/-?\d+/, line)
      |> List.flatten()
      |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.map(&List.to_tuple/1)
  end
end
