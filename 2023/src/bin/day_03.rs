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

fn is_part_number(symbol: &Symbol, number: &PartNumber) -> bool {
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

    (number.x..number.x + number.width).any(|x| positions_to_check.contains(&(x, number.y)))
}

fn numbers_and_symbols(input: &str) -> (Vec<PartNumber>, Vec<Symbol>) {
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

    (all_numbers, all_symbols)
}

fn adjacent_numbers(all_numbers: &Vec<PartNumber>, symbol: &Symbol, part_numbers: &mut Vec<u32>) {
    for number in all_numbers {
        if is_part_number(symbol, number) {
            part_numbers.push(number.value);
        }
    }
}

fn part_1(input: &str) -> u32 {
    let (all_numbers, all_symbols) = numbers_and_symbols(input);

    let mut part_numbers = Vec::new();
    for symbol in &all_symbols {
        adjacent_numbers(&all_numbers, symbol, &mut part_numbers);
    }

    part_numbers.iter().sum::<u32>()
}

fn part_2(input: &str) -> u32 {
    let (all_numbers, all_symbols) = numbers_and_symbols(input);
    let mut gear_ratios: Vec<u32> = Vec::new();
    for symbol in &all_symbols {
        let mut symbol_parts = Vec::new();
        adjacent_numbers(&all_numbers, symbol, &mut symbol_parts);

        if symbol_parts.len() == 2 {
            gear_ratios.push(symbol_parts.iter().product());
        }
    }

    gear_ratios.iter().sum()
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
        assert_eq!(part_2(include_str!("inputs/day_03_example_1")), 467_835);
        assert_eq!(part_2(include_str!("inputs/day_03")), 87_605_697);
    }
}
