fn part_1(input: &str) -> u32 {
    sum_calibration_values(input, false)
}

fn part_2(input: &str) -> u32 {
    sum_calibration_values(input, true)
}

fn sum_calibration_values(input: &str, use_spelled: bool) -> u32 {
    input
        .lines()
        .map(|line| calibration_value(line, use_spelled))
        .sum::<u32>()
}

fn calibration_value(line: &str, use_spelled: bool) -> u32 {
    let valid_numbers = [
        ("one", 1),
        ("two", 2),
        ("three", 3),
        ("four", 4),
        ("five", 5),
        ("six", 6),
        ("seven", 7),
        ("eight", 8),
        ("nine", 9),
    ];

    let mut matches = (0..line.len()).filter_map(|i| {
        let slice = &line[i..];

        for (spelled, digit) in valid_numbers {
            if slice.starts_with(&digit.to_string()) || (use_spelled && slice.starts_with(spelled))
            {
                return Some(digit);
            }
        }

        None
    });

    let first_digit = matches.next().unwrap();
    let last_digit = matches.last().unwrap_or(first_digit);
    first_digit * 10 + last_digit
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
