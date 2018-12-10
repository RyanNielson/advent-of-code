# This one was tricky because you have you have to examine the output to get the answer.
# Unfortunetely the automated testing didn't do much to verify solutions today.
class Day10
  def part1(input)
    points = parse(input)

    20000.times.each do |i|
      print(points)

      points = points.map do |point|
        [point[0] + point[2], point[1] + point[3], point[2], point[3]]
      end
    end
  end

  def part2(input)
    points = parse(input)

    10240.times.each do |i|
      points = points.map do |point|
        [point[0] + point[2], point[1] + point[3], point[2], point[3]]
      end
    end

    print(points)
  end

  def print(points)
    x_range, y_range = bounding_box(points)

    point_count = points.count

    if x_range.count <= point_count && y_range.count <= point_count
      printer = points.reduce(Hash.new(".")) do |to_print, point|
        to_print[[point[0], point[1]]] = "#"
        to_print
      end

      y_range.each do |y|
        puts x_range.reduce("") { |line, x| line << printer[[x, y]] }
      end

      puts "\n"
    end
  end

  def bounding_box(points)
    x_min, x_max = points.map{ |point| point[0] }.minmax
    y_min, y_max = points.map{ |point| point[1] }.minmax

    [x_min..x_max, y_min..y_max]
  end

  def parse(input)
    input.split("\n").map do |line|
      /position=<(\s*\-?\d+), (\s*\-?\d+)> velocity=<(\s*\-?\d+), (\s*\-?\d+)>/.match(line).captures.map(&:to_i)
    end
  end
end
