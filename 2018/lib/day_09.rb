class Marble
  attr_reader :value
  attr_accessor :cw, :ccw

  def initialize(value)
    @value = value
    @cw  = self
    @ccw = self
  end

  def place(current_marble)
    first = current_marble.cw
    second = first.cw

    first.cw = self
    second.ccw = self
    @cw = second
    @ccw = first

    self
  end

  def remove_7_ccw
    remove = @ccw.ccw.ccw.ccw.ccw.ccw.ccw

    remove.cw.ccw = remove.ccw
    remove.ccw.cw = remove.cw

    remove
  end

  def multiple_of_23?
    @value % 23 == 0
  end
end

class Day09
  def part1(input)
    player_count, last_number = parse(input)

    play(player_count, last_number)
  end

  def part2(input)
    player_count, last_number = parse(input)

    play(player_count, last_number * 100)
  end

  def play(player_count, last_number)
    current_marble = create_first_marble
    players = Hash.new(0)
    turns = turns(player_count, last_number)

    turns.each.with_index(1) do |player, value|
      marble = Marble.new(value)

      if marble.multiple_of_23?
        removed = current_marble.remove_7_ccw
        current_marble = removed.cw

        players[player] += marble.value + removed.value
      else
        current_marble = marble.place(current_marble)
      end
    end

    players

    players.values.max
  end

  def create_first_marble
    current_marble = Marble.new(0)
    current_marble.cw = current_marble
    current_marble.ccw = current_marble
  end

  def turns(player_count, last_number)
    turns = []

    (1..player_count).to_a.cycle do |player|
      break if turns.count >= last_number

      turns << player
    end

    turns
  end

  def parse(input)
    /(\d+) players; last marble is worth (\d+) points/.match(input).captures.map(&:to_i)
  end
end
