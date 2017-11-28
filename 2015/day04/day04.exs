defmodule Day04 do
  def run(path, start), do: work(0, secret_key(path), start)

  defp work(i, key, start) do
    case String.starts_with?(hash(key, i), start) do
      true  -> to_string(i)
      false -> work(i + 1, key, start)
    end
  end

  defp secret_key(path), do: File.read!(path) |> String.strip

  defp hash(key, number), do: :crypto.hash(:md5, key <> to_string(number)) |> Base.encode16
end

IO.puts "Part 1: " <> Day04.run("day04.input", "00000")
IO.puts "Part 2: " <> Day04.run("day04.input", "000000")
