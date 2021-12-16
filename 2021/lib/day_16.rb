class Day16
  def part1(input)
    versions(Packet.from_hex(input)).sum
  end

  def part2(input)
    expression_value(Packet.from_hex(input))
  end

  def versions(packet)
    [packet.version, packet.subpackets.map { |subpacket| versions(subpacket) }].flatten
  end

  def expression_value(packet)
    return packet.value if packet.literal?

    values = packet.subpackets.map { |subpacket| expression_value(subpacket) }

    case packet.type_id
    when 0
      values.sum
    when 1
      values.reduce(:*)
    when 2
      values.min
    when 3
      values.max
    when 5
      values[0] > values[1] ? 1 : 0
    when 6
      values[0] < values[1] ? 1 : 0
    when 7
      values[0] == values[1] ? 1 : 0
    end
  end
end

class Packet
  attr_accessor :version, :type_id, :value, :subpackets, :remainder

  class << self
    def from_hex(hex)
      bits = [hex].pack("H*").unpack1("B*")
      Packet.new(bits)
    end

    def from_bits(bits)
      Packet.new(bits)
    end
  end

  def initialize(bit_string)
    bits = bit_string.chars
    @version = bits.shift(3).join.to_i(2)
    @type_id = bits.shift(3).join.to_i(2)
    @subpackets = []

    if literal?
      parse_literal(bits)
    else
      parse_operator(bits)
    end
  end

  def parse_literal(bits)
    pieces = []
    loop do
      start, *rest = bits.shift(5)
      pieces << rest
      break if start == "0"
    end

    @value = pieces.flatten.join.to_i(2)
    @remainder = bits.join
  end

  def parse_operator(bits)
    case bits.shift(1).first.to_i
    when 0
      subpacket_length = bits.shift(15).join.to_i(2)
      subpacket_bits = bits.shift(subpacket_length).join

      while subpacket_length.positive?
        packet = Packet.from_bits(subpacket_bits)
        subpacket_length = (packet.remainder&.length || 0)
        subpacket_bits = packet.remainder
        @subpackets << packet
      end

      @remainder = bits.join
    when 1
      number_of_subpackets = bits.shift(11).join.to_i(2)
      subpacket_bits = bits.join

      @subpackets = number_of_subpackets.times.map do |_i|
        packet = Packet.from_bits(subpacket_bits)
        @remainder = subpacket_bits = packet.remainder
        packet
      end
    end
  end

  def literal?
    @type_id == 4
  end
end
