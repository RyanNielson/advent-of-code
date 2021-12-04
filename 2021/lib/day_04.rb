class Board
  def initialize(input)
    @grid = input.map { _1.split.map(&:to_i) }
    @winning_draw = nil
  end

  def dab(drawn)
    return false if @winning_draw

    (0..4).each do |row|
      (0..4).each do |col|
        @grid[row][col] = :dabbed if @grid[row][col] == drawn
      end
    end

    @winning_draw = drawn if contains_line?
    !@winning_draw.nil?
  end

  def contains_line?
    filled_row = (0..4).any? { |i| @grid[i].all? { _1 == :dabbed } }
    filled_column = (0..4).any? { |i| @grid.transpose[i].all? { _1 == :dabbed } }
    filled_row || filled_column
  end

  def score
    @grid.flatten.reject { _1 == :dabbed }.sum * @winning_draw
  end
end

class Day04
  def part1(input)
    play(input).first.score
  end

  def part2(input)
    play(input).last.score
  end

  def play(input)
    numbers, *board_inputs = input.split("\n").reject(&:empty?)
    boards = board_inputs.each_slice(5).map { Board.new(_1) }

    numbers.split(",").map(&:to_i).each_with_object([]) do |d, winners|
      boards.each { |b| winners << b if b.dab(d) }
    end
  end
end
