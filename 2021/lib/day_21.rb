class Day21
  def part1(input)
    deterministic_rolls = (1..100).to_a
    rolls_count = 0
    positions, scores = parse_input(input)

    [0, 1].cycle do |player|
      move(positions, scores, player, deterministic_rolls)
      rolls_count += 3
      break if scores[player] >= 1000
    end

    scores.min * rolls_count
  end

  def move(positions, scores, player, deterministic_rolls)
    amount = deterministic_rolls[0, 3].sum
    deterministic_rolls.rotate!(3)
    positions[player] = (positions[player] + amount) % 10
    scores[player] += positions[player] + 1
  end

  POSSIBLE_ROLLS = [1, 2, 3].product([1, 2, 3], [1, 2, 3]).map(&:sum)

  def part2(input)
    positions, scores = parse_input(input)
    play(positions, scores, 0, {}).max
  end

  def play(positions, scores, player, memo)
    return memo[[positions, scores, player]] if memo.include?([positions, scores, player])
    return [1, 0] if scores[0] >= 21
    return [0, 1] if scores[1] >= 21

    wins = POSSIBLE_ROLLS.map do |amount|
      positions_dup = positions.dup
      scores_dup = scores.dup
      positions_dup[player] = (positions_dup[player] + amount) % 10
      scores_dup[player] += positions_dup[player] + 1
      play(positions_dup, scores_dup, player.zero? ? 1 : 0, memo)
    end

    memo[[positions, scores, player]] = wins.transpose.map(&:sum)
  end

  def parse_input(input)
    players = input.split("\n").map do |line|
      _, position = line.split(":")
      position.to_i
    end

    [[players[0] - 1, players[1] - 1], [0, 0]]
  end
end
