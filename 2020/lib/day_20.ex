defmodule Day20 do
  def part1(input) do
    foods =
      input
      |> parse()

    allergens_map = build_allergen_map(foods)
    all_ingredients = build_all_ingredients(foods)

    allergens_set =
      allergens_map
      |> Map.values()
      |> Enum.reduce(fn allergens, acc -> MapSet.union(allergens, acc) end)

    all_ingredients
    |> Enum.reject(&MapSet.member?(allergens_set, &1))
    |> Enum.count()
  end

  defp build_allergen_map(foods) do
    foods
    |> Enum.reduce(%{}, fn {ingredients, allergens}, allergens_map ->
      allergens
      |> Enum.map(fn allergen ->
        {allergen, ingredients}
      end)
      |> Enum.reduce(allergens_map, fn {allergen, ingredients}, new_allergens_map ->
        case Map.get(new_allergens_map, allergen, nil) do
          nil ->
            Map.put(new_allergens_map, allergen, MapSet.new(ingredients))

          a ->
            Map.put(new_allergens_map, allergen, MapSet.intersection(a, MapSet.new(ingredients)))
        end
      end)
    end)
  end

  defp build_all_ingredients(foods) do
    Enum.flat_map(foods, fn {ingredients, _} -> ingredients end)
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [ingredients_part, allergens_part] =
        ~r/([\w\s]+) \(contains ([\w\s,]+)\)/
        |> Regex.run(line, capture: :all_but_first)

      ingredients = String.split(ingredients_part, " ")
      allergens = String.split(allergens_part, ", ")

      {ingredients, allergens}
    end)
  end
end
