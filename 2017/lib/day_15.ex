defmodule AdventOfCode2017.Day15 do
  use Bitwise, only: :operators

  @a_factor 16807
  @b_factor 48271
  @divisor  2147483647
  @part1_iterations 40_000_000
  @part2_iterations 5_000_000

  def part1(input) do
    {a_start, b_start} = input |> parse()

    a_gen = generator(a_start, @a_factor)
    b_gen = generator(b_start, @b_factor)

    count_generated_values(a_gen, b_gen, @part1_iterations)
  end

  def part2(input) do
    {a_start, b_start} = input |> parse()

    a_gen = generator_picky(a_start, @a_factor, 4)
    b_gen = generator_picky(b_start, @b_factor, 8)

    count_generated_values(a_gen, b_gen, @part2_iterations)
  end

  defp generator(start, factor) do
    Stream.unfold({start, factor}, &generate/1)
  end

  defp generator_picky(start, factor, divisor) do
    generator(start, factor)
    |> Stream.filter(&(rem(&1, divisor) == 0))
  end

  defp count_generated_values(a_gen, b_gen, iterations) do
    Stream.zip(a_gen, b_gen)
    |> Stream.take(iterations)
    |> Stream.filter(&judged?/1)
    |> Enum.count()
  end

  defp judged?({a, b}), do: (a &&& 0xffff) == (b &&& 0xffff)

  defp generate({prev, factor}) do
    next = rem(prev * factor, @divisor)
    {next, {next, factor}}
  end

  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn (line) ->
      line |> String.split() |> List.last() |> String.to_integer()
    end)
    |> List.to_tuple()
  end
 end