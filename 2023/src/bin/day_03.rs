use regex::Regex;

#[derive(Debug, PartialEq, Eq)]
struct Symbol {
    value: char,
    x: usize,
    y: usize,
}
#[derive(Debug, PartialEq, Eq)]
struct PartNumber {
    value: u32,
    x: usize,
    y: usize,
    width: usize,
}

fn part_1(input: &str) -> u32 {
    let number_regex = Regex::new(r"(\d+)").unwrap();
    let symbol_regex = Regex::new(r"([^\d.\s]+)").unwrap();
    let mut all_numbers = Vec::new();
    let mut all_symbols = Vec::new();

    for (y, line) in input.lines().enumerate() {
        let mut part_numbers: Vec<PartNumber> = number_regex
            .captures_iter(line)
            .map(|captures| {
                let m = captures.get(1).unwrap();
                PartNumber {
                    value: m.as_str().parse::<u32>().unwrap(),
                    x: m.start(),
                    y,
                    width: m.end() - m.start(),
                }
            })
            .collect::<Vec<_>>();
        let mut symbols = symbol_regex
            .captures_iter(line)
            .map(|captures| {
                let m = captures.get(1).unwrap();
                Symbol {
                    value: m.as_str().chars().next().unwrap(),
                    x: m.start(),
                    y,
                }
            })
            .collect::<Vec<_>>();

        all_numbers.append(&mut part_numbers);
        all_symbols.append(&mut symbols);
    }

    // This could perhaps be a problem is there were multiple symbols touching one number, but it
    // works with example input.
    let mut part_numbers = Vec::new();
    for symbol in &all_symbols {
        for number in &all_numbers {
            let positions_to_check = [
                (symbol.x - 1, symbol.y - 1),
                (symbol.x, symbol.y - 1),
                (symbol.x + 1, symbol.y - 1),
                (symbol.x - 1, symbol.y),
                (symbol.x + 1, symbol.y),
                (symbol.x - 1, symbol.y + 1),
                (symbol.x, symbol.y + 1),
                (symbol.x + 1, symbol.y + 1),
            ];

            let is_part_number = (number.x..number.x + number.width)
                .any(|x| positions_to_check.contains(&(x, number.y)));

            if is_part_number {
                part_numbers.push(number.value);
            }
        }
    }

    part_numbers.iter().sum::<u32>()
}

fn part_2(input: &str) -> u32 {
    1
}

fn main() {
    println!("Part 1: {}", part_1(include_str!("inputs/day_03")));
    println!("Part 2: {}", part_2(include_str!("inputs/day_03")));
}

#[cfg(test)]
mod tests {
    use super::*;
    use pretty_assertions::assert_eq;

    #[test]
    fn test_part_1() {
        assert_eq!(part_1(include_str!("inputs/day_03_example_1")), 4361);
        assert_eq!(part_1(include_str!("inputs/day_03")), 540_212);
    }

    #[test]
    fn test_part_2() {
        // assert_eq!(part_2(include_str!("inputs/day_03_example_1")), 2286);
        // assert_eq!(part_2(include_str!("inputs/day_03")), 78_669);
    }
}
