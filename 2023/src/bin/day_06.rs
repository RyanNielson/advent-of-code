#[derive(Debug, PartialEq, Eq)]
struct Race {
    time: usize,
    best_distance: usize,
}

impl Race {
    fn number_of_ways_to_win(&self) -> usize {
        (0..self.time)
            .map(|held| held * (self.time - held))
            .filter(|distance| *distance > self.best_distance)
            .count()
    }
}

fn part_1(input: &str) -> usize {
    let mut lines = input.lines().map(|line| {
        line.split_whitespace()
            .skip(1)
            .map(|num: &str| num.parse::<usize>().unwrap())
    });

    lines
        .next()
        .unwrap()
        .zip(lines.next().unwrap())
        .map(|(time, best_distance)| Race {
            time,
            best_distance,
        })
        .map(|race| race.number_of_ways_to_win())
        .product::<usize>()
}

fn part_2(input: &str) -> usize {
    let mut lines = input.lines().map(|line| {
        line.split_whitespace()
            .skip(1)
            .collect::<String>()
            .parse::<usize>()
            .unwrap()
    });

    let race = Race {
        time: lines.next().unwrap(),
        best_distance: lines.next().unwrap(),
    };

    race.number_of_ways_to_win()
}

fn main() {
    println!("Part 1: {}", part_1(include_str!("inputs/day_06")));
    println!("Part 2: {}", part_2(include_str!("inputs/day_06")));
}

#[cfg(test)]
mod tests {
    use super::*;
    use pretty_assertions::assert_eq;

    #[test]
    fn test_part_1() {
        assert_eq!(part_1(include_str!("inputs/day_06_example_1")), 288);
        assert_eq!(part_1(include_str!("inputs/day_06")), 741_000);
    }

    #[test]
    fn test_part_2() {
        assert_eq!(part_2(include_str!("inputs/day_06_example_1")), 71_503);
        assert_eq!(part_2(include_str!("inputs/day_06")), 38_220_708);
    }
}
