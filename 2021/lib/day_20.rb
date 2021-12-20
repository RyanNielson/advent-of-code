require "active_support/all"

class Day20
  def part1(input)
    algorithm, image = parse(input)
    enhance_and_count(image, algorithm, 2)
  end

  def part2(input)
    algorithm, image = parse(input)
    enhance_and_count(image, algorithm, 50)
  end

  def enhance_and_count(image, algorithm, steps)
    steps.times.reduce(image) do |new_image, i|
      if algorithm.first == "#"
        new_image.default = i.odd? ? "#" : "."
      end

      enhance(algorithm, new_image)
    end.values.count("#")
  end

  def enhance(algorithm, image)
    new_image = {}
    min_x, max_x = image.keys.minmax_by(&:x)
    min_y, max_y = image.keys.minmax_by(&:y)

    ((min_y.y - 1)..(max_y.y + 1)).each do |y|
      ((min_x.x - 1)..(max_x.x + 1)).each do |x|
        position = Position.new(x, y)
        number = [Position.new(x - 1, y - 1),
                  Position.new(x, y - 1),
                  Position.new(x + 1, y - 1),
                  Position.new(x - 1, y),
                  position,
                  Position.new(x + 1, y),
                  Position.new(x - 1, y + 1),
                  Position.new(x, y + 1),
                  Position.new(x + 1, y + 1)].map do |pos|
          image[pos] == "#" ? "1" : "0"
        end.join.to_i(2)

        new_image[position] = algorithm[number]
      end
    end

    new_image
  end

  def parse(input)
    algorithm_input, image_input = input.split("\n\n")

    image = image_input.split("\n").each_with_index.each_with_object(Hash.new(".")) do |(row, y), acc|
      row.chars.each_with_index { |pixel, x| acc[Position.new(x, y)] = pixel }
    end

    [algorithm_input.chars, image]
  end
end

Position = Struct.new(:x, :y)
