defmodule Day01 do
  def run(directions) do
    directions
    |> parse
    |> move({0, 0}, :N)
    |> distance
  end

  def parse(directions) do
    directions
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&build_movement_tuple/1)
  end

  def build_movement_tuple(string) do
    command = String.split_at(string, 1)
    { String.to_atom(elem(command, 0)), String.to_integer(elem(command, 1)) }
  end

  def move([{turn_direction, distance} | directions], location, heading) do
    new_heading = turn(heading, turn_direction)
    new_location = travel(location, new_heading, distance)
    move(directions, new_location, new_heading)
  end

  def move([], location, heading), do: location

  def turn(:N, :L), do: :W
  def turn(:N, :R), do: :E
  def turn(:E, :L), do: :N
  def turn(:E, :R), do: :S
  def turn(:S, :L), do: :E
  def turn(:S, :R), do: :W
  def turn(:W, :L), do: :S
  def turn(:W, :R), do: :N

  def travel({x, y}, :N, distance), do: {x, y + distance}
  def travel({x, y}, :E, distance), do: {x + distance, y}
  def travel({x, y}, :S, distance), do: {x, y - distance}
  def travel({x, y}, :W, distance), do: {x - distance, y}

  def distance({x, y}), do: abs(x) + abs(y)
end
