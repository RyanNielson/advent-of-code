# frozen_string_literal: true

require "test_helper"
require "day_16"

class Day16Test < Minitest::Test
  def test_part1
    day = Day16.new

    assert_equal 16, day.part1("8A004A801A8002F478")
    assert_equal 12, day.part1("620080001611562C8802118E34")
    assert_equal 23, day.part1("C0015000016115A2E0802F182340")
    assert_equal 31, day.part1("A0016C880162017C3686B18A3D4780")
    assert_equal 991, day.part1(input("day_16"))
  end

  def test_part2
    day = Day16.new

    assert_equal 3, day.part2("C200B40A82")
    assert_equal 54, day.part2("04005AC33890")
    assert_equal 7, day.part2("880086C3E88112")
    assert_equal 9, day.part2("CE00C43D881120")
    assert_equal 1, day.part2("D8005AC2A8F0")
    assert_equal 0, day.part2("F600BC2D8F")
    assert_equal 0, day.part2("9C005AC2F8F0")
    assert_equal 1, day.part2("9C0141080250320F1802104A08")
    assert_equal 1_264_485_568_252, day.part2(input("day_16"))
  end
end
