class Day20
  def part1(input)
    enhance_and_count(Image.new(input), 2)
  end

  def part2(input)
    enhance_and_count(Image.new(input), 50)
  end

  def enhance_and_count(image, steps)
    steps.times { image.enhance }
    image.count
  end
end

Position = Struct.new(:x, :y)

class Image
  def initialize(input)
    @algorithm, @pixels = parse(input)
    @enhancements = 0
  end

  def enhance
    if @algorithm.first == "#"
      @pixels.default = @enhancements.odd? ? "#" : "."
    end

    new_pixels = {}
    min_x, max_x, min_y, max_y = expanded_bounds

    (min_y..max_y).each do |y|
      (min_x..max_x).each do |x|
        position = Position.new(x, y)
        new_pixels[position] = @algorithm[determine_number(position)]
      end
    end

    @enhancements += 1
    @pixels = new_pixels
  end

  def determine_number(position)
    x, y = position.values
    [Position.new(x - 1, y - 1),
     Position.new(x, y - 1),
     Position.new(x + 1, y - 1),
     Position.new(x - 1, y),
     position,
     Position.new(x + 1, y),
     Position.new(x - 1, y + 1),
     Position.new(x, y + 1),
     Position.new(x + 1, y + 1)].map do |check_position|
      @pixels[check_position] == "#" ? "1" : "0"
    end.join.to_i(2)
  end

  def parse(input)
    algorithm_input, pixels_input = input.split("\n\n")

    pixels = pixels_input.split("\n").each_with_index.each_with_object(Hash.new(".")) do |(row, y), acc|
      row.chars.each_with_index { |pixel, x| acc[Position.new(x, y)] = pixel }
    end

    [algorithm_input.chars, pixels]
  end

  def count
    @pixels.values.count("#")
  end

  def expanded_bounds
    min_x, max_x = @pixels.keys.minmax_by(&:x)
    min_y, max_y = @pixels.keys.minmax_by(&:y)
    [min_x.x - 1, max_x.x + 1, min_y.y - 1, max_y.y + 1]
  end
end
