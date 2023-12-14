defmodule Platform do
  defstruct [:rocks, :width, :height]

  def new(cells) do
    rocks = Map.new(cells)

    {width, _} = rocks |> Map.keys() |> Enum.max_by(fn {x, _} -> x end)
    {_, height} = rocks |> Map.keys() |> Enum.max_by(fn {_, y} -> y end)

    %Platform{rocks: rocks, width: width, height: height}
  end

  def tilt_north(%Platform{rocks: rocks, height: height} = platform) do
    new_rocks =
      rocks
      |> Map.keys()
      |> Enum.sort_by(&elem(&1, 1), :desc)
      |> Enum.reduce(rocks, fn {x, y} = position, rocks ->
        rock = Map.get(rocks, position)

        case rock do
          "O" ->
            hit_y =
              y..height
              |> Enum.find(
                height,
                fn y ->
                  next_rock = Map.get(rocks, {x, y + 1})
                  next_rock == "#" || next_rock == "O"
                end
              )

            rocks |> Map.delete({x, y}) |> Map.put({x, hit_y}, rock)

          "#" ->
            rocks

          nil ->
            rocks
        end
      end)

    %{platform | rocks: new_rocks}
  end

  def total_load(%Platform{rocks: rocks}) do
    rocks
    |> Map.filter(fn {_position, rock} -> rock == "O" end)
    |> Map.keys()
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end
end

defmodule Day14 do
  def part_1(input) do
    input
    |> parse()
    |> Platform.tilt_north()
    |> Platform.total_load()
  end

  def part_2(input) do
    input
    |> parse()
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, y} ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.map(fn {char, x} ->
        case char do
          c when c in ["#", "O"] -> {{x + 1, y + 1}, c}
          _ -> nil
        end
      end)
      |> Enum.reject(&is_nil/1)
    end)
    |> Platform.new()
  end
end
