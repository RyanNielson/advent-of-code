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
        let red_regex = Regex::new(r"(\d+) red").unwrap();
        let green_regex = Regex::new(r"(\d+) green").unwrap();
        let blue_regex = Regex::new(r"(\d+) blue").unwrap();

        let red_max = red_regex
            .captures_iter(s)
            .map(|x| x.get(1).unwrap().as_str().parse::<u32>())
            .filter_map(|x| x.ok())
            .max()
            .unwrap();

        let green_max = green_regex
            .captures_iter(s)
            .map(|x| x.get(1).unwrap().as_str().parse::<u32>())
            .filter_map(|x| x.ok())
            .max()
            .unwrap();

        let blue_max = blue_regex
            .captures_iter(s)
            .map(|x| x.get(1).unwrap().as_str().parse::<u32>())
            .filter_map(|x| x.ok())
            .max()
            .unwrap();

        Ok(Self {
            red_max,
            green_max,
            blue_max,
        })
    }
}

fn part_1(input: &str) -> usize {
    // only 12 red cubes, 13 green cubes, and 14 blue cubes
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
    1
    // sum_calibration_values(input, true)
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
        // assert_eq!(part_2(include_str!("inputs/day_02_example_1")), 281);
        // assert_eq!(part_2(include_str!("inputs/day_02")), 54_578);
    }
}

// // #[derive(Debug, Clone, Copy)]
// // enum Colour {
// //     Red,
// //     Green,
// //     Blue,
// // }

// use regex::Regex;
// use std::str::FromStr;

// // TODO: Maybe instead of set for part one we just track the highest r, g, b for each round and use that.
// #[derive(Debug, Clone, Copy)]
// struct Set {
//     red: u32,
//     green: u32,
//     blue: u32,
// }

// #[derive(Debug, PartialEq, Eq)]
// struct ParseSetError;

// impl FromStr for Set {
//     type Err = ParseSetError;

//     fn from_str(s: &str) -> Result<Self, Self::Err> {
//         // "3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"
//         // dbg!(s.split(","));
//         println!("STRING: {s}");

//         let red_regex = Regex::new(r"(\d) red").unwrap();
//         let green_regex = Regex::new(r"(\d) green").unwrap();
//         let blue_regex = Regex::new(r"(\d) blue").unwrap();

//         let red_count = red_regex.captures(s).unwrap().get(1).unwrap().as_str();
//         let blue_count = blue_regex.captures(s).unwrap().get(1).unwrap().as_str();
//         let green_count = green_regex.captures(s).unwrap().get(1).unwrap().as_str();
//         println!("RED: {red_count}");
//         println!("BLUE: {blue_count}");
//         println!("GREEN: {green_count}");
//         // let (_, Some(num)) = red_regex.captures(s) {
//         //     println("CAPTURED {num}");
//         // } else {
//         //     println!("NO RED");
//         // }
//         // println!("{:?}", red_regex.captures(s));

//         Ok(Self {
//             red: 1,
//             green: 1,
//             blue: 1,
//         })
//         // todo!()
//     }
// }

// struct Game {
//     sets: Vec<Set>,
// }

// // impl FromStr for Game {
// //     type Err;

// //     fn from_str(s: &str) -> Result<Self, Self::Err> {
// //         todo!()
// //     }
// // }

// fn part_1(input: &str) -> u32 {
//     println!("{:?}", Set::from_str("3 blue, 4 red"));

//     1
//     // sum_calibration_values(input, false)
// }

// fn part_2(input: &str) -> u32 {
//     1
//     // sum_calibration_values(input, true)
// }

// fn main() {
//     println!("Part 1: {}", part_1(include_str!("inputs/day_02")));
//     println!("Part 2: {}", part_2(include_str!("inputs/day_02")));
// }

// #[cfg(test)]
// mod tests {
//     use super::*;
//     use pretty_assertions::assert_eq;

//     #[test]
//     fn test_part_1() {
//         assert_eq!(part_1(include_str!("inputs/day_02_example_1")), 8);
//         // assert_eq!(part_1(include_str!("inputs/day_02")), 55_208);
//     }

//     #[test]
//     fn test_part_2() {
//         // assert_eq!(part_2(include_str!("inputs/day_02_example_1")), 281);
//         // assert_eq!(part_2(include_str!("inputs/day_02")), 54_578);
//     }
// }
