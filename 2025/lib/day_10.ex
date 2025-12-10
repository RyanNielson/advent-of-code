defmodule Day10 do
  def part_1(input) do
    machines =
      input
      |> String.split("\n")
      |> Enum.map(fn line ->
        diagram =
          ~r/\[(.+)\]/
          |> Regex.run(line)
          |> then(fn [_, contents] -> String.graphemes(contents) end)

        buttons =
          ~r/\(([\d,]+)\)/
          |> Regex.scan(line)
          |> Enum.map(fn [_, contents] ->
            contents
            |> String.split(",")
            |> Enum.map(&String.to_integer/1)
          end)

        {diagram, buttons}
      end)

    machines
    |> Enum.map(fn {diagram, buttons} ->
      empty_lights = diagram |> Enum.map(fn _ -> "." end)
      button_combinations = buttons |> combinations()

      button_combinations
      |> Enum.reduce_while(0, fn combination, _count ->
        result =
          combination
          |> Enum.reduce(empty_lights, fn button, lights ->
            button
            |> Enum.reduce(lights, fn index, temp_lights ->
              temp_lights
              |> List.update_at(index, fn value ->
                case value do
                  "#" -> "."
                  "." -> "#"
                end
              end)
            end)
          end)

        if result == diagram, do: {:halt, length(combination)}, else: {:cont, 0}
      end)
    end)
    |> Enum.sum()
  end

  defp combinations(list) do
    1..length(list)
    |> Enum.flat_map(&combinations(list, &1))
  end

  defp combinations(_, 0), do: [[]]
  defp combinations([], _), do: []

  defp combinations([h | t], k) do
    with_h =
      t
      |> combinations(k - 1)
      |> Enum.map(&[h | &1])

    with_h ++ combinations(t, k)
  end

  def part_2(input) do
    input
  end
end
