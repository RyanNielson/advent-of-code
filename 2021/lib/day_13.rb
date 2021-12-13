require "set"

class Day13
  def part1(input)
    paper, folds = parse_input(input)
    paper.fold(folds[0])
    paper.count
  end

  def part2(input)
    paper, folds = parse_input(input)
    folds.each { paper.fold(_1) }
    paper.visualize
  end

  def parse_input(input)
    input_lines = input.split("\n")
    empty_index = input_lines.find_index("")
    dots_input = input_lines.slice(0...empty_index)
    folds_input = input_lines.slice((empty_index + 1)..-1)

    dots = dots_input.map { Point.new(*_1.split(",").map(&:to_i)) }
    folds = folds_input.map do |i|
      inst, pos = i.split("=")
      FoldInstruction.new(inst[-1], pos.to_i)
    end

    [Paper.new(dots), folds]
  end
end

Point = Struct.new(:x, :y)
FoldInstruction = Struct.new(:direction, :position)

class Paper
  def initialize(dots)
    @dots = dots.to_set
  end

  def fold(instruction)
    position = instruction.position
    @dots = @dots.clone.reduce(Set.new) do |dots, dot|
      if instruction.direction == "y" && dot.y > position
        dots.add(Point.new(dot.x, position - (dot.y - position)))
      elsif instruction.direction == "x" && dot.x > position
        dots.add(Point.new(position - (dot.x - position), dot.y))
      else
        dots.add(dot)
      end
    end
  end

  def count
    @dots.count
  end

  def visualize
    min_x, max_x = @dots.minmax_by(&:x)
    min_y, max_y = @dots.minmax_by(&:y)

    (min_y.y..max_y.y)
      .map do |y|
        (min_x.x..max_x.x).reduce("") do |line, x|
          line << (@dots.include?(Point.new(x, y)) ? "#" : ".")
        end
      end
      .join("\n")
  end
end
