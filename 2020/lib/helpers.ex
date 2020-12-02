defmodule Helpers do
  def input(file) do
    file
    |> Path.absname("test/input")
    |> File.read!()
    |> String.trim()
  end

  def parse_to_integer_list(input, pattern) do
    input
    |> String.split(pattern, trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def parse_to_list(input, pattern) do
    input
    |> String.split(pattern, trim: true)
  end
end
