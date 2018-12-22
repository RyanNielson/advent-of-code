class Day22
  def part1(depth, target_x, target_y)
    regions = (0..target_x).to_a.product((0..target_y).to_a)

    cave = regions.reduce({}) do |c, (x, y)|
      geologic_index = geologic_index(x, y, target_x, target_y, c)
      erosion_level  = erosion_level(geologic_index, depth)
      type = type(erosion_level)
      risk_level = risk_level(type)

      c[[x, y]] = [geologic_index, erosion_level, type, risk_level]

      c
    end

    cave.sum { |k, v| v.last }
  end

  def risk_level(type)
    case type
    when :rocky then 0
    when :wet then 1
    when :narrow then 2
    end
  end

  def geologic_index(x, y, target_x, target_y, cave)
    if x == 0 && y == 0
      0
    elsif x == target_x && y == target_y
      0
    elsif y == 0
      x * 16807
    elsif x == 0
      y * 48271
    else
      _, erosion_level_1 = cave[[x - 1, y]]
      _, erosion_level_2 = cave[[x, y - 1]]

      erosion_level_1 * erosion_level_2
    end
  end

  def erosion_level(geologic_index, depth)
    (geologic_index + depth) % 20183
  end

  def type(erosion_level)
    type_index = erosion_level % 3

    case type_index
    when 0 then :rocky
    when 1 then :wet
    when 2 then :narrow
    end
  end
end