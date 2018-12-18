#TODO: UNFINISHED
class Day15
  def part1(input)
    map = parse(input)

    puts map.inspect

    map.display
  end

  def parse(input)
    height = input.split("\n").length
    width = input.split("\n").first.length
    input.split("\n").each.with_index.reduce(Map.new(width, height)) do |map, (row, y)|
      row.strip.chars.each_with_index do |c, x|
        case c
        when "#" then map.set_cell!(x, y, false)
        when "." then map.set_cell!(x, y, true)
        when "E" then map.add_unit!(x, y, c)
        when "G" then map.add_unit!(x, y, c)
        end
      end

      map
    end
  end
end

class Unit
  attr_accessor :hp, :damage, :team, :position

  def initialize(team, position)
    @hp = 200
    @damage = 3
    @team = team
    @position = position
  end

  def died?
    @hp <= 0
  end
end

class Map
  def initialize(width, height)
    @grid = Array.new(height) { Array.new(width) }
    @width = width
    @height = height
  end

  def set_cell!(x, y, value)
    @grid[y][x] = value
  end


  def get_cell(x, y)
    @grid[y][x]
  end

  def add_unit!(x, y, type)
    set_cell!(x, y, Unit.new(type, [x, y]))
  end

  def display
    (0...@height).to_a.each do |y|
      row = ""
      (0...@width).to_a.map do |x|
        cell = get_cell(x, y)

        if cell.is_a?(Unit)
          row << cell.team
        else
          row << (@grid[y][x] ? "." : "#")
        end
      end

      puts row
    end
  end
end
