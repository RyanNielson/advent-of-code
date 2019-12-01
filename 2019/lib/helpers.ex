defmodule Helpers do
  def input(file), do: file |> Path.absname("test/input") |> File.read!() |> String.trim()
end
