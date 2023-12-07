use std::{collections::HashMap, str::FromStr};

use itertools::Itertools;

#[derive(Debug, PartialEq, Eq, PartialOrd, Ord, Clone, Copy)]
enum HandType {
    FiveOfAKind,
    FourOfAKind,
    FullHouse,
    ThreeOfAKind,
    TwoPair,
    OnePair,
    HighCard,
}

#[derive(Debug, PartialEq, Eq, PartialOrd, Ord, Hash)]
enum Card {
    Ace,
    King,
    Queen,
    Jack,
    Ten,
    Nine,
    Eight,
    Seven,
    Six,
    Five,
    Four,
    Three,
    Two,
}

#[derive(Debug, PartialEq, Eq)]
struct ParseCardError;

impl From<char> for Card {
    fn from(value: char) -> Self {
        match value {
            'A' => Card::Ace,
            'K' => Card::King,
            'Q' => Card::Queen,
            'J' => Card::Jack,
            'T' => Card::Ten,
            '9' => Card::Nine,
            '8' => Card::Eight,
            '7' => Card::Seven,
            '6' => Card::Six,
            '5' => Card::Five,
            '4' => Card::Four,
            '3' => Card::Three,
            '2' => Card::Two,
            _ => unreachable!(),
        }
    }
}

#[derive(Debug, PartialEq, Eq)]
struct ParseHandError;

#[derive(Debug, PartialEq, Eq)]
struct Hand {
    cards: Vec<Card>,
    hand_type: HandType,
    bid: usize,
}

impl FromStr for Hand {
    type Err = ParseHandError;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let (cards_str, bid_str) = s.split_once(' ').unwrap();
        let cards = cards_str.chars().map(Card::from).collect_vec();

        let mut card_counts = HashMap::new();
        for card in cards.iter() {
            *card_counts.entry(card).or_insert(0) += 1usize
        }

        let sorted_card_counts = card_counts.values().sorted();

        let hand_type = match sorted_card_counts.as_slice() {
            [5] => HandType::FiveOfAKind,
            [1, 4] => HandType::FourOfAKind,
            [2, 3] => HandType::FullHouse,
            [1, 1, 3] => HandType::ThreeOfAKind,
            [1, 2, 2] => HandType::TwoPair,
            [1, 1, 1, 2] => HandType::OnePair,
            [1, 1, 1, 1, 1] => HandType::HighCard,
            _ => unreachable!(),
        };

        let bid = bid_str.parse().unwrap();

        Ok(Hand {
            cards,
            hand_type,
            bid,
        })
    }
}

impl Ord for Hand {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        if self.hand_type == other.hand_type {
            let zipped = self.cards.iter().zip(other.cards.iter());
            for (a, b) in zipped {
                if a != b {
                    return a.cmp(b);
                }
            }
        }

        self.hand_type.cmp(&other.hand_type)
    }
}
impl PartialOrd for Hand {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        Some(self.cmp(other))
    }
}

fn part_1(input: &str) -> usize {
    let a = HandType::OnePair;
    let b = HandType::TwoPair;

    println!("A < B {}", a < b);
    let mut hands = input
        .lines()
        .map(|line| Hand::from_str(line).unwrap())
        .collect::<Vec<_>>();

    hands.sort();

    hands
        .iter()
        .rev()
        .enumerate()
        .map(|(rank, card)| card.bid * (rank + 1))
        .sum()
}

fn part_2(_input: &str) -> usize {
    1
}

fn main() {
    println!("Part 1: {}", part_1(include_str!("inputs/day_07")));
    println!("Part 2: {}", part_2(include_str!("inputs/day_07")));
}

#[cfg(test)]
mod tests {
    use super::*;
    use pretty_assertions::assert_eq;

    #[test]
    fn test_part_1() {
        assert_eq!(part_1(include_str!("inputs/day_07_example_1")), 6440);
        assert_eq!(part_1(include_str!("inputs/day_07")), 249_204_891);
    }

    #[test]
    fn test_part_2() {
        // assert_eq!(part_2(include_str!("inputs/day_07_example_1")), 71_503);
        // assert_eq!(part_2(include_str!("inputs/day_07")), 38_220_708);
    }
}
