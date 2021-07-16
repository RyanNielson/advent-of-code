require 'set'
require 'digest'

class Day04
  def part1(input)
    0.step.find do |i|
      hash = Digest::MD5.hexdigest("#{input}#{i}")
      hash.start_with?('00000')
    end
  end

  def part2(input)
    0.step.find do |i|
      hash = Digest::MD5.hexdigest("#{input}#{i}")
      hash.start_with?('000000')
    end
  end
end
