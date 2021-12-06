class Day06
  def part1(input)
    spawn(initial_timers(input), 80)
  end

  def part2(input)
    spawn(initial_timers(input), 256)
  end

  def spawn(timers, days)
    days
      .times
      .each_with_object(timers) do |_, t|
        t.rotate!
        t[6] += t[8]
      end
      .sum
  end

  def initial_timers(input)
    input
      .split(",")
      .map(&:to_i)
      .each_with_object(Array.new(9, 0)) { |i, t| t[i] += 1 }
  end
end
