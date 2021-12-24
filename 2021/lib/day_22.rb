require "set"
require "active_support/all"

class Day22
  STEP_PATTERN = /(\w+) x=(.+),y=(.+),z=(.+)/

  def clamp_range(range)
    min = range.min
    max = range.max

    return nil if min < -50 && max < -50
    return nil if min > 50 && max > 50

    (min.clamp(-50, 50)..max.clamp(-50, 50))
  end

  def part1(input)
    steps = parse_steps(input)
    steps
      .each_with_object(Set.new) do |(state, x_range, y_range, z_range), reactors|
        # TODO: Pattern matching instead?
        # TODO: Just get all values and find the possible products/combinations/permutations?
        x_range = clamp_range(x_range)
        y_range = clamp_range(y_range)
        z_range = clamp_range(z_range)

        next if x_range.nil? || y_range.nil? || z_range.nil?

        x_range.each do |x|
          y_range.each do |y|
            z_range.each do |z|
              if state == "on"
                reactors.add([x, y, z])
              elsif state == "off"
                reactors.delete([x, y, z])
              end
            end
          end
        end
      end
      .count
    # split_input = input.split.map(&:to_i)
  end

  # TODO: Maybe just store on ranges, and get intersections between ranges?
  # TODO: If a ON range intersects with an OFF range, then splut the ON range and limit accordingly.
  # TODO: Just store a list of ranges with a corresponding value (1 or 1). Then at the end sum all those together
  # (though this might not work if offs don't intersect with existing on ranges)

  class Cuboid
    attr_accessor :x_range, :y_range, :z_range, :state

    def initialize(x_range, _y_range, z_range, state)
      @x_range = x_range
      @y_range = x_range
      @z_range = z_range
      @state = state
    end

    def volume
      x_range.size * y_range.size * z_range.size
    end

    def range_intersection(range1, range2)
      min1 = range1.min
      max1 = range1.max
      min2 = range2.min
      max2 = range2.max

      # return nil if max1 < min2
      # return nil if min1 > max2

      return nil unless range1.overlaps?(range2)

      ([min1, min2].max..[max1, max2].min)
    end

    def intersection(other, new_state)
      x_intersection = range_intersection(x_range, other.x_range)
      y_intersection = range_intersection(y_range, other.y_range)
      z_intersection = range_intersection(z_range, other.z_range)

      return nil if x_intersection.nil? || y_intersection.nil? || z_intersection.nil?

      Cuboid.new(x_intersection, y_intersection, z_intersection, new_state)
    end

    def on?
      state == "on"
    end

    def off?
      state == "off"
    end
  end

  # Slightly different take: I only compute the intersection of new regions
  # with existing ones. Every time a region is intersected, the intersection is added
  # to the list with opposite sign. This is bookkeeping a bit like lanternfish, but it
  # saves me implementing pesky segmentation functions, in favor of one simple intersection
  # function.

  # TODO: Unfinished
  def part2(input)
    steps = parse_steps(input)

    all_cuboids = steps.map do |(state, x_range, y_range, z_range)|
      Cuboid.new(x_range, y_range, z_range, state)
    end

    cuboids = []

    total_volume = 0
    all_cuboids.each_with_index.map do |cuboid, i|
      off_cuboids = cuboids.filter(&:off?)
      on_cuboids = cuboids.filter(&:on?)

      if cuboid.on?
        total_volume += cuboid.volume
        cuboids << cuboid
      end

      p i
      p on_cuboids
      on_cuboids.each do |previous|
        intersection = previous.intersection(cuboid, "on")
        unless intersection.nil?
          total_volume -= intersection.volume
          cuboids << intersection
        end
      end

      off_cuboids.each do |previous|
        intersection = previous.intersection(cuboid, "off")
        unless intersection.nil?
          total_volume += intersection.volume
          cuboids << intersection
        end
      end

      p total_volume
    end

    total_volume
  end

  def part2a(input)
    steps = parse_steps(input)
    count = 0

    all_cuboids = steps.map do |(state, x_range, y_range, z_range)|
      Cuboid.new(x_range, y_range, z_range, state)
    end

    cuboids = []

    total_volume = 0
    all_cuboids.each_with_index.map do |cuboid, _i|
      if cuboid.on?
        total_volume += cuboid.volume if cuboid.on?
        cuboids << cuboid
      end

      cuboids.filter(&:on?).each do |previous|
        intersection = previous.intersection(cuboid, "off")
        unless intersection.nil?
          volume -= intersection.volume
          cuboids << intersection
        end
      end

      cuboids.filter(&:off?).each do |previous|
        intersection = previous.intersection(cuboid, "on")
        unless intersection.nil?
          volume += intersection.volume
          cuboids << intersection
        end
      end

      total_volume
    end

    total_volume

    # p cuboids

    # cuboids = steps.reduce([]) do |cuboids, (state, x_range, y_range, z_range)|
    #   cuboid = Cuboid.new(x_range, y_range, z_range, state)

    #   # DOES THIS NEED TO BE DIFFERENT IF OFF?
    #   count += cuboids.reduce(cuboid.volume) do |acc, previous_cuboid|
    #     # p previous_cuboid
    #     # IF COLLIDES WITH ON SUBTRACT INTERSECTION VOLUME
    #     # IF COLLIDES WITH OFF ADD INTERSECTION VOLUME

    #     intersection = previous_cuboid.intersection(cuboid)
    #     p "INTERSECTION"

    #     p previous_cuboid
    #     p cuboid
    #     p intersection
    #     p acc
    #     p cuboid.volume
    #     p intersection.volume
    #     # 0

    #     if previous_cuboid.state == "on" && cuboid.state == "on"
    #       acc + (cuboid.volume - intersection.volume)
    #     elsif previous_cuboid.state == "on" && cuboid.state == "off"
    #       acc - intersection.volume
    #     end
    #     # return acc - intersection.volume if previous_cuboid.state == "on" && cuboid.state == "on"
    #     # return acc - intersection.volume if previous_cuboid.state == "on" && cuboid.state == "off"

    #     # IF PREVIOUS IS ON AND CURRENT IS ON THEN ADD CURRENTVOLUME - INTERSECTION VOLUME TO TOTAL
    #   end

    #   p count

    #   p "---"

    #   cuboids << cuboid
    #   # IF ON GET INTERSECTIONS WITH ON CUBES AND ADD TO VOLUMN
    #   # GO THROUGH EACH PREVIOUS AND SUBTRACT
    # end

    # cuboids.reduce(0) do |count, cuboid|
    #   p cuboid
    #   p count
    #   to_add = 0
    #   if cuboid.state == "on"
    #     puts "ON"
    #   else
    #     puts "OFF"
    #   end

    #   count + to_add
    # end

    # steps
    #   .each_with_object(Set.new) do |(state, x_range, y_range, z_range), reactors|
    #     # # TODO: Pattern matching instead?
    #     # # TODO: Just get all values and find the possible products/combinations/permutations?
    #     # x_range = clamp_range(x_range)
    #     # y_range = clamp_range(y_range)
    #     # z_range = clamp_range(z_range)

    #     # next if x_range.nil? || y_range.nil? || z_range.nil?

    #     # IF ON, SET ALL CUBES. IF OFF, limit range to min and max of existing off items.
    #     if state == "on"
    #       puts "ON"
    #       x_range.each do |x|
    #         y_range.each do |y|
    #           z_range.each do |z|
    #             reactors.add([x, y, z])
    #           end
    #         end
    #       end
    #     elsif state == "off"
    #       puts "OFF"
    #     end

    #     # x_range.each do |x|
    #     #   y_range.each do |y|
    #     #     z_range.each do |z|
    #     #       if state == "on"
    #     #         reactors.add([x, y, z])
    #     #       elsif state == "off"
    #     #         reactors.delete([x, y, z])
    #     #       end
    #     #     end
    #     #   end
    #     # end
    #   end
    #   .count
  end

  def parse_steps(input)
    input.split("\n").map do |line|
      state, x, y, z = line.match(STEP_PATTERN)[1, 4]
      [state, eval(x), eval(y), eval(z)]
    end
  end
end
