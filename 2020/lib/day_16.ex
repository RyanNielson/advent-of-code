defmodule Day16 do
  def part1(input) do
    %{"rules" => rules, "nearby" => nearby} =
      input
      |> parse()

    nearby
    |> List.flatten()
    |> Enum.reject(&matches_rules?(rules, &1))
    |> Enum.sum()
  end

  defp matches_rules?(rules, value) do
    rules
    |> Map.values()
    |> Enum.any?(&MapSet.member?(&1, value))
  end

  # TODO: Can probably simplify and combine stuff in here.
  defp parse(input) do
    rules =
      ~r/([\w ]+): (\d+)-(\d+) or (\d+)-(\d+)/
      |> Regex.scan(input, capture: :all_but_first)
      |> Enum.into(%{}, fn [name, a1, a2, b1, b2] ->
        {name,
         MapSet.union(
           MapSet.new(String.to_integer(a1)..String.to_integer(a2)),
           MapSet.new(String.to_integer(b1)..String.to_integer(b2))
         )}
      end)

    [_, your_lines, nearby_lines] =
      input
      |> String.split("\n\n", trim: true)

    your_ticket =
      your_lines
      |> String.split("\n")
      |> Enum.drop(1)
      |> List.first()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    nearby_tickets =
      nearby_lines
      |> String.split("\n")
      |> Enum.drop(1)
      |> Enum.map(&String.split(&1, ","))
      |> Enum.map(fn ticket ->
        ticket |> Enum.map(&String.to_integer/1)
      end)

    %{"rules" => rules, "your" => your_ticket, "nearby" => nearby_tickets}
  end
end
