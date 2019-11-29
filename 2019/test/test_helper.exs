ExUnit.start()

defmodule AdventOfCode2019.TestHelper do
  def input(file), do: file |> Path.absname("test/input") |> File.read() |> String.trim()
end
