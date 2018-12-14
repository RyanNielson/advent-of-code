class Day14
  def part1(number_of_recipes)
    recipes = [3, 7]
    elves = [0, 1]
    total_recipes = number_of_recipes + 10

    while recipes.count < total_recipes do
      recipes = new_recipes(recipes, elves)
      elves = new_elves(elves, recipes)
    end

    recipes.slice(number_of_recipes, 10).join
  end

  def part2(recipe_string)
    recipes = [3, 7]
    elves = [0, 1]

    newly_added = []
    loop do
      10000.times do
        recipes = new_recipes2(recipes, elves, newly_added)
        elves = new_elves(elves, recipes)
      end

      if newly_added.join.include?(recipe_string)
        return recipes.join.index(recipe_string)
      else
        newly_added = newly_added.pop(recipe_string.length)
      end
    end
  end

  def new_recipes2(recipes, elves, newly_added)
    new_recipes = elves.sum{ |elf| recipes[elf] }.digits.reverse
    newly_added.concat(new_recipes)
    recipes.concat(new_recipes)
  end

  def new_recipes(recipes, elves)
    recipes.concat(elves.sum{ |elf| recipes[elf] }.digits.reverse)
  end

  def new_elves(elves, recipes)
    elves.map { |elf| (elf + recipes[elf] + 1) % recipes.count }
  end
end
