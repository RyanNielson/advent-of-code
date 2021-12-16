# TODO: This code is a nightmare, refactor if there's time.
class Day16
  def part1(input)
    Packet.from_hex(input).version_sum
  end

  def part2(input)
    Packet.from_hex(input).expression_value
  end
end

class Packet
  attr_accessor :bits, :version, :type_id, :value, :length_type_id, :subpackets, :remainder

  class << self
    def from_hex(hex)
      bits = [hex].pack("H*").unpack1("B*")
      Packet.new(bits)
    end

    def from_bits(bits)
      Packet.new(bits)
    end
  end

  def initialize(bits)
    @bits = bits
    bit_array = @bits.chars
    @version = bit_array.shift(3).join.to_i(2)
    @type_id = bit_array.shift(3).join.to_i(2)
    @subpackets = []
    @remainder = ""

    if literal?
      pieces = []
      loop do
        start, *rest = bit_array.shift(5)
        pieces << rest
        break if start == "0"
      end

      @value = pieces.flatten.join.to_i(2)
      @remainder = bit_array.join
    elsif operator?
      @length_type_id = bit_array.shift(1).first.to_i

      case @length_type_id
      when 0
        subpacket_length = bit_array.shift(15).join.to_i(2)
        subpacket_bits = bit_array.shift(subpacket_length).join
        subpacket_length_remainder = subpacket_length

        while subpacket_length_remainder > 0
          packet = Packet.from_bits(subpacket_bits)
          subpacket_length_remainder = (packet.remainder&.length || 0)
          subpacket_bits = packet.remainder
          @subpackets << packet
        end

        @remainder = bit_array.join
      when 1
        number_of_subpackets = bit_array.shift(11).join.to_i(2)
        subpacket_bits = bit_array.join

        @subpackets = number_of_subpackets.times.map do |_i|
          packet = Packet.from_bits(subpacket_bits)
          subpacket_bits = packet.remainder
          packet
        end

        @remainder = subpacket_bits
      end
    end
  end

  def literal?
    @type_id == 4
  end

  # An operator packet contains one or more subpackets.
  def operator?
    !literal?
  end

  def version_sum
    versions(self).sum
  end

  def versions(packet)
    [packet.version, packet.subpackets.map { |subpacket| versions(subpacket) }].flatten
  end

  def expression_value
    expression(self)
  end

  def expression(packet)
    return packet.value if packet.literal?

    values = packet.subpackets.map { |subpacket| expression(subpacket) }

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
