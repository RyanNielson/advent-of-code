class Day13
  def part1(input)
    carts, tracks = parse(input)

    loop do
      carts.sort_by! { |c| [c.y, c.x] }

      carts.each do |cart|
        next_x, next_y = cart.next_position

        cart_crashed_into = carts.find { |c| c.x == next_x && c.y == next_y }

        if cart_crashed_into
          return [next_x, next_y].join(",")
        end

        cart.move!(tracks)
      end
    end
  end

  def part2(input)
    carts, tracks = parse(input)

    loop do
      carts.sort_by! { |c| [c.y, c.x] }

      carts.each do |cart|
        next if cart.crashed
        next_x, next_y = cart.next_position

        cart_crashed_into = carts.find { |c| c.x == next_x && c.y == next_y && !c.crashed }

        if cart_crashed_into
          cart.crashed = true
          cart_crashed_into.crashed = true
          next
        end

        cart.move!(tracks)
      end

      if carts.count{ |c| !c.crashed } == 1
        living_cart = carts.find { |c| !c.crashed }
        return [living_cart.x, living_cart.y].join(",")
      end
    end
  end

  def parse(input)
    lines = input.split("\n")

    carts = []

    tracks = lines.map.with_index do |line, y|
      line.chomp.chars.map.with_index do |char, x|
        case char
        when ">"
          carts << Cart.new(x, y, 1, 0)
          "-"
        when "<"
          carts << Cart.new(x, y, -1, 0)
          "-"
        when "^"
          carts << Cart.new(x, y, 0, -1)
          "|"
        when "v"
          carts << Cart.new(x, y, 0, 1)
          "|"
        else
          char
        end
      end
    end

    [carts, tracks]
  end

  def print_track(carts, tracks)
    tracks.each.with_index do |row, y|
      row.each.with_index do |column, x|
        cart = carts.find { |c| c.x == x && c.y == y }

        print cart ? cart : column
      end

      puts ""
    end

    puts "\n"
  end
end

class Cart
  attr_accessor :x, :y, :dx, :dy, :turn_count, :crashed

  def initialize(x, y, dx, dy)
    @x = x
    @y = y
    @dx = dx
    @dy = dy
    @turn_count = 0
    @crashed = false
  end

  def move!(tracks)
    @x += @dx
    @y += @dy


    case tracks[@y][@x]
    when "\\"
      turn_right!
    when "/"
      turn_left!
    when "+"
      crossroad!
    end
  end

  def next_position
    [@x + @dx, @y + @dy]
  end

  def turn_right!
    @dx, @dy = @dy, @dx
  end

  def turn_left!
    @dx, @dy = -@dy, -@dx
  end

  def crossroad!
    case @turn_count
    when 0
      @dx, @dy = @dy, -@dx
    when 2
      @dx, @dy = -@dy, @dx
    end

    @turn_count = (@turn_count + 1) % 3
  end

  def to_s
    return "C" if @crashed

    case [@dx, @dy]
    when [1, 0]
      ">"
    when [-1, 0]
      "<"
    when [0, 1]
      "v"
    when [0, -1]
      "^"
    end
  end
end
