fn part_1(input: &str) -> u32 {
    input
        .lines()
        .map(|line| {
            let first_digit = line.chars().find(|&c| c.is_ascii_digit()).unwrap();
            let last_digit = line.chars().rev().find(|&c| c.is_ascii_digit()).unwrap();
            let num_string = format!("{first_digit}{last_digit}");
            num_string.parse::<u32>().unwrap()
        })
        .sum::<u32>()
}

fn part_2(input: &str) -> u32 {
    let valid_numbers = [
        ("one", "1"),
        ("two", "2"),
        ("three", "3"),
        ("four", "4"),
        ("five", "5"),
        ("six", "6"),
        ("seven", "7"),
        ("eight", "8"),
        ("nine", "9"),
    ];

    input
        .lines()
        .map(|line| {
            let mut matches = (0..line.len()).filter_map(|i| {
                let slice = &line[i..];

                for (spelled, digit) in valid_numbers {
                    if slice.starts_with(digit) || slice.starts_with(spelled) {
                        return Some(digit);
                    }
                }

                None
            });

            let first_digit = matches.next().unwrap();
            let last_digit = matches.last().unwrap_or(first_digit);
            let num_string = format!("{first_digit}{last_digit}");
            num_string.parse::<u32>().unwrap()
        })
        .sum::<u32>()
}

fn main() {
    println!("Part 1: {}", part_1(include_str!("inputs/day_01")));
    println!("Part 2: {}", part_2(include_str!("inputs/day_01")));
}

#[cfg(test)]
mod tests {
    use super::*;
    use pretty_assertions::assert_eq;

    #[test]
    fn test_part_1() {
        assert_eq!(part_1(include_str!("inputs/day_01_example_1")), 142);
        assert_eq!(part_1(include_str!("inputs/day_01")), 55_208);
    }

    #[test]
    fn test_part_2() {
        assert_eq!(part_2(include_str!("inputs/day_01_example_2")), 281);
        assert_eq!(part_2(include_str!("inputs/day_01")), 54_578);
    }
}
