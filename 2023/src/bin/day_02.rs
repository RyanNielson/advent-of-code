use regex::Regex;
use std::str::FromStr;

#[derive(Debug, PartialEq, Eq)]
struct ParseGameError;

#[derive(Debug, PartialEq, Eq)]
struct Game {
    red_max: u32,
    green_max: u32,
    blue_max: u32,
}

impl FromStr for Game {
    type Err = ParseGameError;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        fn max_color(s: &str, regex: Regex) -> u32 {
            regex
                .captures_iter(s)
                .map(|x| x.get(1).unwrap().as_str().parse::<u32>())
                .filter_map(|x| x.ok())
                .max()
                .unwrap()
        }

        Ok(Self {
            red_max: max_color(s, Regex::new(r"(\d+) red").unwrap()),
            green_max: max_color(s, Regex::new(r"(\d+) green").unwrap()),
            blue_max: max_color(s, Regex::new(r"(\d+) blue").unwrap()),
        })
    }
}

fn part_1(input: &str) -> usize {
    input
        .lines()
        .map(|line| Game::from_str(line).unwrap())
        .enumerate()
        .filter_map(|(i, game)| {
            if game.red_max <= 12 && game.green_max <= 13 && game.blue_max <= 14 {
                Some(i + 1)
            } else {
                None
            }
        })
        .sum::<usize>()
}

fn part_2(input: &str) -> u32 {
    input
        .lines()
        .map(|line| Game::from_str(line).unwrap())
        .map(|game| game.red_max * game.green_max * game.blue_max)
        .sum::<u32>()
}

fn main() {
    println!("Part 1: {}", part_1(include_str!("inputs/day_02")));
    println!("Part 2: {}", part_2(include_str!("inputs/day_02")));
}

#[cfg(test)]
mod tests {
    use super::*;
    use pretty_assertions::assert_eq;

    #[test]
    fn test_part_1() {
        assert_eq!(part_1(include_str!("inputs/day_02_example_1")), 8);
        assert_eq!(part_1(include_str!("inputs/day_02")), 2283);
    }

    #[test]
    fn test_part_2() {
        assert_eq!(part_2(include_str!("inputs/day_02_example_1")), 2286);
        assert_eq!(part_2(include_str!("inputs/day_02")), 78_669);
    }
}
