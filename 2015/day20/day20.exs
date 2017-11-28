defmodule Day06 do
  def part1(target) do
    Enum.find(1..target, fn house ->
      house_factor_sum = house |> factors |> Enum.sum
      house_factor_sum * 10 >= target
    end)
  end

  def factors(n) do
    e = n |> :math.sqrt |> trunc

    (1..e)
    |> Enum.flat_map(fn
      x when rem(n, x) != 0 -> []
      x when x != div(n, x) -> [x, div(n, x)]
      x -> [x]
    end)
  end
end


IO.puts "Part 1: " <> to_string(Day06.part1(36000000))
