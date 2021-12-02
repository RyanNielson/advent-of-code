class Day02
  def part1(input)
    input
      .then { commands(_1) }
      .then { move(_1) }
      .then { |p, _, d| p * d }
  end

  def part2(input)
    input
      .then { commands(_1) }
      .then { move(_1) }
      .then { |p, d| p * d }
  end

  private

  def commands(input)
    input.split("\n").map do |command|
      dir, amount = command.split
      [dir, amount.to_i]
    end
  end

  def move(commands)
    commands.each_with_object([0, 0, 0]) do |command, position|
      case command
      in ["forward", i]
        position[0] += i
        position[1] += position[2] * i
      in ["down", i]
        position[2] += i
      in ["up", i]
        position[2] -= i
      end
    end
  end
end
