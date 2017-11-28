defmodule Day07 do
  def run(input) do
    input
    |> parse
    |> count
  end

  def parse(input) do
    input
    |> String.trim
    |> String.split("\n", trim: true)
    |> Enum.map(&Day07.parse_ip/1)
  end

  def parse_ip(ip) do
    ip_pieces = ip |> String.split(["[", "]"])
    { ip_pieces |> Enum.take_every(2), ip_pieces |> Enum.drop_every(2) }
  end

  def tls?({seqs, hypernet_seqs}), do: Enum.any?(seqs, &abba?/1) and not Enum.any?(hypernet_seqs, &abba?/1)

  def abba?(piece) when byte_size(piece) < 4, do: false
  def abba?(<<a::utf8, b::utf8, b::utf8, a::utf8, _rest::binary>>) when a != b, do: true
  def abba?(<<_char::utf8, rest::binary>>), do: abba?(rest)

  def count(ips) do
    Enum.reduce(ips, 0, fn ip, count ->
      count + if tls?(ip), do: 1, else: 0
    end)
  end
end
