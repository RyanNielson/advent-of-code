use std::{
    collections::{HashMap, HashSet},
    str::FromStr,
};

fn part_1(input: &str) -> usize {
    let grid = Grid::from_str(input).unwrap();
    let mut beams = vec![Beam {
        position: Position { x: 0, y: 0 },
        direction: Direction::Right,
    }];
    let mut energized = HashSet::new();
    let mut visited = HashSet::new();

    while let Some(mut beam) = beams.pop() {
        if !grid.contains(&beam) || visited.contains(&(beam.position, beam.direction)) {
            continue;
        }

        energized.insert(beam.position);
        visited.insert((beam.position, beam.direction));

        let char = grid.cells.get(&beam.position).unwrap();

        match char {
            '.' => beam.traverse(),
            '|' | '-' => {
                if let Some(new_beam) = beam.maybe_split(*char) {
                    beams.push(new_beam);
                }
            }
            '/' | '\\' => beam.bounce(*char),
            _ => unreachable!(),
        }

        beams.push(beam);
    }

    energized.len()
}

fn part_2(input: &str) -> isize {
    1
}

#[derive(Debug, Eq, PartialEq, Clone, Copy, Hash)]
enum Direction {
    Up,
    Right,
    Down,
    Left,
}

#[derive(Debug, Eq, PartialEq)]
struct Beam {
    position: Position,
    direction: Direction,
}

impl Beam {
    fn traverse(&mut self) {
        match self.direction {
            Direction::Up => self.position.y -= 1,
            Direction::Right => self.position.x += 1,
            Direction::Down => self.position.y += 1,
            Direction::Left => self.position.x -= 1,
        }
    }

    fn maybe_split(&mut self, char: char) -> Option<Beam> {
        if (self.direction == Direction::Right || self.direction == Direction::Left) && char == '|'
        {
            self.direction = Direction::Up;

            let mut new_beam = Beam {
                direction: Direction::Down,
                position: self.position,
            };
            self.traverse();
            new_beam.traverse();
            return Some(new_beam);
        } else if (self.direction == Direction::Up || self.direction == Direction::Down)
            && char == '-'
        {
            self.direction = Direction::Right;
            let mut new_beam = Beam {
                direction: Direction::Left,
                position: self.position,
            };
            self.traverse();
            new_beam.traverse();
            return Some(new_beam);
        }

        self.traverse();
        None
    }

    fn bounce(&mut self, char: char) {
        match (self.direction, char) {
            (Direction::Up, '/') => self.direction = Direction::Right,
            (Direction::Up, '\\') => self.direction = Direction::Left,
            (Direction::Right, '/') => self.direction = Direction::Up,
            (Direction::Right, '\\') => self.direction = Direction::Down,
            (Direction::Down, '/') => self.direction = Direction::Left,
            (Direction::Down, '\\') => self.direction = Direction::Right,
            (Direction::Left, '/') => self.direction = Direction::Down,
            (Direction::Left, '\\') => self.direction = Direction::Up,
            _ => unreachable!(),
        }

        self.traverse()
    }
}

#[derive(Debug, Eq, PartialEq, Hash, Clone, Copy)]
struct Position {
    x: isize,
    y: isize,
}

#[derive(Debug)]
struct Grid {
    cells: HashMap<Position, char>,
    width: isize,
    height: isize,
}

impl Grid {
    fn contains(&self, beam: &Beam) -> bool {
        let position = &beam.position;
        position.x >= 0 && position.x < self.width && position.y >= 0 && position.y < self.height
    }
}

#[derive(Debug)]
struct ParseGridError;

impl FromStr for Grid {
    type Err = ParseGridError;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let cells = s
            .lines()
            .enumerate()
            .fold(HashMap::new(), |mut acc, (y, line)| {
                for (x, char) in line.chars().enumerate() {
                    let position = Position {
                        x: x as isize,
                        y: y as isize,
                    };
                    acc.insert(position, char);
                }

                acc
            });

        let width = cells.keys().max_by_key(|position| position.x).unwrap().x + 1;
        let height = cells.keys().max_by_key(|position| position.y).unwrap().y + 1;

        Ok(Self {
            cells,
            width,
            height,
        })
    }
}

fn main() {
    println!("Part 1: {}", part_1(include_str!("inputs/day_16")));
    println!("Part 2: {}", part_2(include_str!("inputs/day_16")));
}

#[cfg(test)]
mod tests {
    use super::*;
    use pretty_assertions::assert_eq;

    #[test]
    fn test_part_1() {
        assert_eq!(part_1(include_str!("inputs/day_16_example_1")), 46);
        assert_eq!(part_1(include_str!("inputs/day_16")), 7979);
    }

    #[test]
    fn test_part_2() {
        // assert_eq!(part_2(include_str!("inputs/day_16_example_1")), 145);
        // assert_eq!(part_2(include_str!("inputs/day_16")), 239484);
    }
}
