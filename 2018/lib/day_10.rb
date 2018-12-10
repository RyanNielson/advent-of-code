class Day10
  def parse(input)
    # LOOP THROUGH EACH LINE AND DO THIS
    /position=<(\s*\-?\d+), (\s*\-?\d+)> velocity=<(\s*\-?\d+), (\s*\-?\d+)>/.match(input).captures
  end
end
