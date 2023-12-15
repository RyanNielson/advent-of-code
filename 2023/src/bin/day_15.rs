use std::{collections::HashMap, ops::Rem, str::FromStr};

fn part_1(input: &str) -> usize {
    input.split(',').map(hash).sum()
}

fn part_2(input: &str) -> usize {
    let mut boxes = (0..256)
        .map(|i| (i, Vec::<Lens>::new()))
        .collect::<HashMap<_, _>>();

    let lenses = input
        .split(',')
        .map(|step| Lens::from_str(step).unwrap())
        .collect::<Vec<_>>();

    for lens in lenses {
        let vec = boxes.get_mut(&hash(&lens.label)).unwrap();

        match lens.focal_length {
            Some(_) => {
                if let Some(index) = vec.iter().position(|l| l.label == lens.label) {
                    vec[index] = lens;
                } else {
                    vec.push(lens);
                }
            }
            None => {
                if let Some(index) = vec.iter().position(|l| l.label == lens.label) {
                    vec.remove(index);
                }
            }
        }
    }

    boxes
        .iter()
        .flat_map(|(id, lenses)| {
            lenses
                .iter()
                .enumerate()
                .map(move |(i, lens)| (id + 1) * (i + 1) * lens.focal_length.unwrap())
        })
        .sum()
}

#[derive(Debug)]
struct Lens {
    label: String,
    focal_length: Option<usize>,
}

#[derive(Debug, PartialEq, Eq)]
struct ParseLensError;

impl FromStr for Lens {
    type Err = ParseLensError;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let mut pieces = s.split(['=', '-']);
        let label = pieces.next().unwrap().to_string();
        let focal_length = pieces.next().and_then(|f| f.parse().ok());
        Ok(Self {
            label,
            focal_length,
        })
    }
}

fn hash(step: &str) -> usize {
    step.as_bytes()
        .iter()
        .fold(0, |acc, c| ((acc + *c as usize) * 17).rem(256))
}

fn main() {
    println!("Part 1: {}", part_1(include_str!("inputs/day_15")));
    println!("Part 2: {}", part_2(include_str!("inputs/day_15")));
}

#[cfg(test)]
mod tests {
    use super::*;
    use pretty_assertions::assert_eq;

    #[test]
    fn test_part_1() {
        assert_eq!(part_1(include_str!("inputs/day_15_example_1")), 1320);
        assert_eq!(part_1(include_str!("inputs/day_15")), 511257);
    }

    #[test]
    fn test_part_2() {
        assert_eq!(part_2(include_str!("inputs/day_15_example_1")), 145);
        assert_eq!(part_2(include_str!("inputs/day_15")), 239484);
    }
}
