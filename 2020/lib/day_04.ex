defmodule Day04 do
  def part1(input) do
    input
    |> parse()
    |> Enum.count(fn passport ->
      passport
      |> Map.keys()
      |> Enum.reject(&(&1 == "cid"))
      |> Enum.count() == 7
    end)
  end

  def part2(input) do
    input
    |> parse()
    |> Enum.map(&valid_passport?/1)
    |> Enum.count(& &1)
  end

  defp valid_passport?(
         %{
           "byr" => _,
           "iyr" => _,
           "eyr" => _,
           "hgt" => _,
           "hcl" => _,
           "ecl" => _,
           "pid" => _
         } = passport
       ) do
    passport
    |> Enum.map(&valid_field?(&1))
    |> Enum.all?()
  end

  defp valid_passport?(_), do: false

  # TODO: Some of these can be extracted out into their own shared functions.
  defp valid_field?({"byr", value}) do
    int_value = String.to_integer(value)
    String.length(value) == 4 && int_value >= 1920 && int_value <= 2002
  end

  defp valid_field?({"iyr", value}) do
    int_value = String.to_integer(value)
    String.length(value) == 4 && int_value >= 2010 && int_value <= 2020
  end

  defp valid_field?({"eyr", value}) do
    int_value = String.to_integer(value)
    String.length(value) == 4 && int_value >= 2020 && int_value <= 2030
  end

  defp valid_field?({"hgt", value}) do
    {num, unit} = Integer.parse(value)
    (unit == "cm" && num >= 150 && num <= 193) || (unit == "in" && num >= 59 && num <= 76)
  end

  defp valid_field?({"hcl", value}) do
    String.match?(value, ~r/^#[\da-f]{6}$/)
  end

  defp valid_field?({"ecl", value}) do
    Enum.member?(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"], value)
  end

  defp valid_field?({"pid", value}) do
    String.match?(value, ~r/^[\d]{9}$/)
  end

  defp valid_field?({"cid", _}) do
    true
  end

  defp parse(input) do
    input
    |> Helpers.parse_to_list("\n\n")
    |> Enum.map(fn passport ->
      passport
      |> String.split(~r{\s}, trim: true)
      |> Enum.reduce(%{}, fn field, acc ->
        [name, value] = String.split(field, ":")
        Map.put(acc, name, value)
      end)
    end)
  end
end
