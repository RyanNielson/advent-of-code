defmodule Day07 do
  def part1(input) do
    input
    |> parse(&part_1_map/4)
    |> contains?("shiny gold")
    |> Enum.count()
  end

  def part2(input) do
    input
    |> parse(&part_2_map/4)
    |> bag_count("shiny gold")
  end

  defp contains?(map, bag) do
    case Map.pop(map, bag) do
      {nil, _} ->
        []

      {bags_contained, new_map} ->
        bags_contained
        |> Enum.flat_map(fn {contained_bag, _} ->
          [contained_bag] ++ contains?(new_map, contained_bag)
        end)
        |> Enum.uniq()
    end
  end

  defp bag_count(map, bag) do
    case Map.pop(map, bag) do
      {nil, _} ->
        0

      {bags_contained, new_map} ->
        bags_contained
        |> Enum.map(fn {contained_bag, count} ->
          count + count * bag_count(new_map, contained_bag)
        end)
        |> Enum.sum()
    end
  end

  defp parse(input, mapping_func) do
    input
    |> Helpers.parse_to_list("\n")
    |> Enum.reduce(%{}, fn line, acc ->
      [bag, contains] = Regex.run(~r/(.+) bags contain (.+)/, line, capture: :all_but_first)

      contained_bags =
        contains
        |> String.split(",", trim: true)
        |> Enum.map(fn contain_bag ->
          case Regex.run(~r/(\d+) (.+) bags?\.?/, contain_bag, capture: :all_but_first) do
            nil -> nil
            [count, bag_name] -> {bag_name, String.to_integer(count)}
          end
        end)
        |> Enum.reject(&is_nil/1)

      contained_bags
      |> Enum.reduce(acc, fn {contained_bag, count}, acc_inner ->
        mapping_func.(bag, contained_bag, count, acc_inner)
      end)
    end)
  end

  defp part_1_map(bag, contained_bag, count, inner_map) do
    Map.update(inner_map, contained_bag, [{bag, count}], fn existing_value ->
      [{bag, count} | existing_value]
    end)
  end

  defp part_2_map(bag, contained_bag, count, inner_map) do
    Map.update(inner_map, bag, [{contained_bag, count}], fn existing_value ->
      [{contained_bag, count} | existing_value]
    end)
  end
end
