defmodule Day04Test do
  use ExUnit.Case
  doctest Day04

  test "parse into room" do
    assert Day04.Room.parse("aaaaa-bbb-z-y-x-123[abxyz]") == %Day04.Room{name: "aaaaa-bbb-z-y-x", id: 123, checksum: "abxyz"}
    assert Day04.Room.parse("a-b-c-d-e-f-g-h-987[abcde]") == %Day04.Room{name: "a-b-c-d-e-f-g-h", id: 987, checksum: "abcde"}
  end

  test "most common 5 letters" do
    room1 = %Day04.Room{name: "aaaaa-bbb-z-y-x", id: 123, checksum: "abxyz"}
    room2 = %Day04.Room{name: "a-b-c-d-e-f-g-h", id: 987, checksum: "abcde"}

    assert Day04.Room.most_common_5_letters(room1) == "abxyz"
    assert Day04.Room.most_common_5_letters(room2) == "abcde"
  end

  test "parse" do
    assert Day04.parse(input_simple) == [
      %Day04.Room{checksum: "abxyz", id: 123, name: "aaaaa-bbb-z-y-x"},
      %Day04.Room{checksum: "abcde", id: 987, name: "a-b-c-d-e-f-g-h"},
      %Day04.Room{checksum: "oarel", id: 404, name: "not-a-real-room"},
      %Day04.Room{checksum: "decoy", id: 200, name: "totally-real-room"}
    ]
  end

  test "run" do
    assert Day04.run(input_simple) == 1514
    assert Day04.run(input) == 173787
  end

  defp input_simple do
    File.read!("test/input/day_04_simple.txt")
  end

  defp input do
    File.read!("test/input/day_04.txt")
  end
end
