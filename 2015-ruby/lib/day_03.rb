require 'set'

class Day03
  def part1(input)
    directions = prepare_directions(input)
    locations = Set.new([[0, 0]])

    directions.reduce([0, 0]) do |last_position, direction|
      new_position = move_position(direction, last_position)
      locations << new_position
      new_position
    end

    locations.size
  end

  # Can probably do something nicer here with #cycle but this works for now.
  def part2(input)
    directions = prepare_directions(input)
    santa_locations = Set.new([[0, 0]])
    elf_locations = Set.new([[0, 0]])
    santas_turn = true

    directions.reduce([[0, 0], [0,0]]) do |(santa_location, elf_location), direction|
      new_position = new_position = move_position(direction, santas_turn ? santa_location : elf_location)

      if santas_turn 
        santa_locations << new_position
      else
        elf_locations << new_position
      end

      santas_turn = !santas_turn

      # This is backward because I have to flip before returning
      santas_turn ? [santa_location, new_position] : [new_position, elf_location] 
    end

    (santa_locations | elf_locations).size
  end

  def move_position(direction, (last_x, last_y))
    case direction
    when '^' then [last_x, last_y + 1]
    when 'v' then [last_x, last_y - 1]
    when '>' then [last_x + 1, last_y]
    when '<' then [last_x - 1, last_y]
    end
  end

  def prepare_directions(input) input.split(//) end
end
