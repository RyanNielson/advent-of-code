defmodule Day02 do
  def run(path), do: Enum.reduce(sizes(path), 0, &paper_area/2)

  defp paper_area(size, acc) do
    side_areas = side_areas(size)

    acc + 2 * Enum.sum(side_areas) + Enum.min(side_areas)
  end

  defp side_areas(size) do
    [l | [w | [h | _]]] = size

    [l * w, w * h, h * l]
  end

  defp sizes(path), do: File.read!(path) |> String.split("\n", trim: true) |> Enum.map(&split_size/1)

  defp split_size(size), do: String.split(size, "x") |> Enum.map(&String.to_integer/1)
end

IO.puts Day02.run("day02.input")
