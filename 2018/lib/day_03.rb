class Day03
  def part1(input)
    claims = split_input(input)
    fabric = build_fabric(claims)

    fabric.count { |k, v| v == "X"}
  end

  def part2(input)
    claims = split_input(input)
    fabric = build_fabric(claims)

    claims.reduce(nil) do |intact_id, claim|
      id, x_start, y_start, width, height = claim_data(claim)

      intact = true

      claim_coords(x_start, y_start, width, height).each do |coord|
        intact = fabric[coord] != "X" && intact
      end

      intact ? id : intact_id
    end
  end

  def build_fabric(claims)
    claims.reduce(Hash.new(0)) do |fabric, claim|
      id, x_start, y_start, width, height = claim_data(claim)

      claim_coords(x_start, y_start, width, height).each do |coord|
        fabric[coord] = fabric.has_key?(coord) ? "X" : id
      end

      fabric
    end
  end

  def claim_coords(x_start, y_start, width, height)
    x_range = (x_start...x_start + width).to_a
    y_range = (y_start...y_start + height).to_a

    x_range.product(y_range)
  end

  def claim_data(claim)
    /#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/.match(claim).captures.map(&:to_i)
  end

  def split_input(input)
    input.split("\n").map(&:strip)
  end
end
