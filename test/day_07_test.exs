defmodule Day07Test do
  use ExUnit.Case
  doctest Day07

  test "run for part 1" do
    assert Day07.run(input_simple) == 2
    assert Day07.run(input) == 105
  end

  test "parse" do
    assert Day07.parse(input_simple) == parsed_input
  end

  test "parse_ip" do
    assert Day07.parse_ip("abba[mnop]qrst") == {["abba", "qrst"], ["mnop"]}
    assert Day07.parse_ip("ioxxoj[asdfgh]zxcvbn") == {["ioxxoj", "zxcvbn"], ["asdfgh"]}
  end

  test "abba?" do
    assert Day07.abba?("ioxxoj") == true
    assert Day07.abba?("xyyx") == true
    assert Day07.abba?("abcddcba") == true
    assert Day07.abba?("aaaa") == false
    assert Day07.abba?("mnop") == false
    assert Day07.abba?("ioxxoj") == true
    assert Day07.abba?("odd") == false
  end

  test "tls?" do
    assert Day07.tls?({["abba", "qrst"], ["mnop"]}) == true
    assert Day07.tls?({["abcd", "xyyx"], ["bddb"]}) == false
  end

  test "count" do
    assert Day07.count(parsed_input) == 2
  end

  defp input_simple do
    File.read!("test/input/day_07_simple.txt")
  end

  defp input do
    File.read!("test/input/day_07.txt")
  end

  defp parsed_input do
    [
      {["abba", "qrst"], ["mnop"]},
      {["abcd", "xyyx"], ["bddb"]},
      {["aaaa", "tyui"], ["qwer"]},
      {["ioxxoj", "zxcvbn"], ["asdfgh"]}
    ]
  end
end
