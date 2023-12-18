use itertools::Itertools;

fn part_1(input: &str) -> isize {
    solve(input, false)
}

fn part_2(input: &str) -> isize {
    solve(input, true)
}

fn solve(input: &str, use_color: bool) -> isize {
    let plan = input
        .lines()
        .map(|line| {
            let mut pieces = line.split_whitespace();

            if use_color {
                let (colour_amount, colour_direction) = pieces
                    .nth(2)
                    .unwrap()
                    .trim_matches(|c| c == '(' || c == ')' || c == '#')
                    .split_at(5);

                let direction = match colour_direction {
                    "0" => 'R',
                    "1" => 'D',
                    "2" => 'L',
                    "3" => 'U',
                    _ => unreachable!(),
                };

                let amount = isize::from_str_radix(colour_amount, 16).unwrap();

                (direction, amount)
            } else {
                let direction = pieces.next().unwrap().chars().next().unwrap();
                let amount = pieces.next().unwrap().parse::<isize>().unwrap();
                (direction, amount)
            }
        })
        .collect_vec();

    let mut current_vertex = Position { x: 0, y: 0 };
    let mut vertices = vec![current_vertex];
    let mut edge_count = 0;

    for (direction, amount) in plan {
        match direction {
            'R' => current_vertex.x += amount,
            'L' => current_vertex.x -= amount,
            'U' => current_vertex.y -= amount,
            'D' => current_vertex.y += amount,
            _ => unreachable!(),
        };

        edge_count += amount;

        vertices.push(current_vertex);
    }

    // Use shoelace formula + pick's algorithm
    let mut area = 0;
    for (a, b) in vertices.iter().tuple_windows() {
        area += a.x * b.y - b.x * a.y;
    }
    area /= 2;

    let inner = area + 1 - edge_count / 2;

    edge_count + inner
}

#[derive(Debug, Eq, PartialEq, Hash, Clone, Copy)]
struct Position {
    x: isize,
    y: isize,
}

fn main() {
    println!("Part 1: {}", part_1(include_str!("inputs/day_18")));
    println!("Part 2: {}", part_2(include_str!("inputs/day_18")));
}

#[cfg(test)]
mod tests {
    use super::*;
    use pretty_assertions::assert_eq;

    #[test]
    fn test_part_1() {
        assert_eq!(part_1(include_str!("inputs/day_18_example_1")), 62);
        assert_eq!(part_1(include_str!("inputs/day_18")), 52231);
    }

    #[test]
    fn test_part_2() {
        assert_eq!(
            part_2(include_str!("inputs/day_18_example_1")),
            952408144115
        );
        assert_eq!(part_2(include_str!("inputs/day_18")), 57196493937398);
    }
}
