defmodule Day12 do
  def part_1(input) do
    input
    |> parse()
    |> Task.async_stream(fn {springs, regex} ->
      # ^ This cuts runtime down to about 30% compared to using Enum.map
      springs
      |> arrangements()
      |> Enum.count(fn arrangement -> Regex.match?(regex, arrangement) end)
    end)
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end

  defp arrangements(line) do
    if String.contains?(line, "?") do
      [prefix, suffix] = String.split(line, "?", parts: 2)
      with_dot = arrangements(prefix <> "." <> suffix)
      with_hash = arrangements(prefix <> "#" <> suffix)

      Enum.concat([with_dot, with_hash])
    else
      [line]
    end
  end

  def part_2(input) do
    input
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [springs, counts] = line |> String.split()

      counts_pattern =
        counts
        |> String.split(",")
        |> Enum.map(&String.to_integer/1)
        |> Enum.map(&"#\{#{&1}\}")
        |> Enum.join("[\.]+")

      {springs, Regex.compile!("^[\.]*#{counts_pattern}[\.]*$", "m")}
    end)
  end
end
