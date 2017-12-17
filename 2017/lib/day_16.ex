defmodule AdventOfCode2017.Day16 do
  @initial_programs "abcdefghijklmnop"

  def part1(input, programs \\ @initial_programs) do
    program_list = String.graphemes(programs)
    
    input
    |> parse()
    |> move(program_list)
    |> List.to_string()
  end

  def move(moves, programs) do
    Enum.reduce(moves, programs, fn (move, progs) ->
      case move do
        {"s", amount} -> spin(progs, amount)
        {"x", a, b}   -> exchange(progs, a, b)
        {"p", a, b}   -> partner(progs, a, b)
      end
    end)
  end

  def spin(programs, amount) do
    {head, tail} = programs
    |> Enum.split(-amount)

    tail ++ head
  end

  def exchange(programs, a, b) do
    first = Enum.at(programs, a)
    second = Enum.at(programs, b)

    programs 
    |> List.replace_at(a, second)
    |> List.replace_at(b, first)
  end

  def partner(programs, a, b) do
    index_a = Enum.find_index(programs, fn x -> x == a end)
    index_b = Enum.find_index(programs, fn x -> x == b end)

    exchange(programs, index_a, index_b)
  end

  def parse(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.map(&parse_move/1)
  end

  def parse_move(move) do
    {type, arguments} = String.split_at(move, 1)

    parse_type(type, String.split(arguments, "/"))
  end

  defp parse_type("s", [arg]), do: {"s", String.to_integer(arg)}
  defp parse_type("x", [a, b]), do: {"x", String.to_integer(a), String.to_integer(b)}
  defp parse_type("p", [a, b]), do: {"p", a, b}
 end