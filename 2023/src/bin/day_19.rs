use std::{collections::HashMap, str::FromStr};

use itertools::Itertools;

fn part_1(input: &str) -> usize {
    let (workflows, ratings) = input
        .split_once("\n\n")
        .map(|(workflows, ratings)| {
            (
                workflows
                    .lines()
                    .map(|line| Workflow::from_str(line).unwrap())
                    .map(|workflow| (workflow.name.clone(), workflow))
                    .collect::<HashMap<_, _>>(),
                ratings
                    .lines()
                    .map(|line| Rating::from_str(line).unwrap())
                    .collect_vec(),
            )
        })
        .unwrap();

    ratings
        .iter()
        .filter(|rating| solve(&workflows, rating))
        .map(|rating| rating.values.values().sum::<usize>())
        .sum()
}

fn part_2(_input: &str) -> usize {
    1
}

fn solve(workflows: &HashMap<String, Workflow>, ratings: &Rating) -> bool {
    let mut current = "in".to_string();

    while let Some(workflow) = workflows.get(&current) {
        for rule in workflow.rules.iter() {
            if rule.operation.is_none() {
                current = rule.target.clone();
                break;
            } else {
                let value = match rule.operation.unwrap() {
                    Operation::GreaterThan => {
                        *ratings.values.get(&rule.subject.unwrap()).unwrap() > rule.value
                    }
                    Operation::LessThan => {
                        *ratings.values.get(&rule.subject.unwrap()).unwrap() < rule.value
                    }
                };

                if value {
                    current = rule.target.clone();
                    break;
                }
            }
        }
    }

    current == "A"
}

fn main() {
    println!("Part 1: {}", part_1(include_str!("inputs/day_18")));
    println!("Part 2: {}", part_2(include_str!("inputs/day_18")));
}

#[derive(Debug, Eq, PartialEq, Hash, Clone, Copy)]
enum Subject {
    X,
    M,
    A,
    S,
}

impl FromStr for Subject {
    type Err = ();

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        match s {
            "x" => Ok(Subject::X),
            "m" => Ok(Subject::M),
            "a" => Ok(Subject::A),
            "s" => Ok(Subject::S),
            _ => unreachable!(),
        }
    }
}

impl FromStr for Rating {
    type Err = ();

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let values = s
            .trim_matches(|c| c == '{' || c == '}')
            .split(',')
            .map(|piece| {
                let (left, right) = piece.split('=').collect_tuple().unwrap();
                (
                    Subject::from_str(left).unwrap(),
                    right.parse::<usize>().unwrap(),
                )
            })
            .collect::<HashMap<_, _>>();

        Ok(Rating { values })
    }
}

#[derive(Debug, Eq, PartialEq, Hash, Clone, Copy)]
enum Operation {
    GreaterThan,
    LessThan,
}

#[derive(Debug, Eq, PartialEq, Hash, Clone)]
struct Rule {
    subject: Option<Subject>,
    target: String,
    value: usize,
    operation: Option<Operation>,
}

#[derive(Debug, Eq, PartialEq, Hash, Clone)]
struct Workflow {
    name: String,
    rules: Vec<Rule>,
}

#[derive(Debug, Eq, PartialEq, Clone)]
struct Rating {
    values: HashMap<Subject, usize>,
}

impl FromStr for Rule {
    type Err = ();

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        if s.contains('<') {
            let mut pieces = s.split(&['<', ':']);
            let subject = pieces.next().unwrap();
            let value = pieces.next().unwrap();
            let target = pieces.next().unwrap();

            Ok(Rule {
                subject: Some(Subject::from_str(subject).unwrap()),
                target: target.to_string(),
                value: value.parse::<usize>().unwrap(),
                operation: Some(Operation::LessThan),
            })
        } else if s.contains('>') {
            let mut pieces = s.split(&['>', ':']);
            let subject = pieces.next().unwrap();
            let value = pieces.next().unwrap();
            let target = pieces.next().unwrap();

            Ok(Rule {
                subject: Some(Subject::from_str(subject).unwrap()),
                target: target.to_string(),
                value: value.parse::<usize>().unwrap(),
                operation: Some(Operation::GreaterThan),
            })
        } else {
            Ok(Rule {
                subject: None,
                target: s.to_string(),
                value: 0,
                operation: None,
            })
        }
    }
}

impl FromStr for Workflow {
    type Err = ();

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let mut pieces = s.split(&['{', '}']);
        let name = pieces.next().unwrap();
        let rules_string = pieces.next().unwrap();

        Ok(Self {
            name: String::from(name),
            rules: rules_string
                .split(',')
                .map(|rule| Rule::from_str(rule).unwrap())
                .collect_vec(),
        })
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use pretty_assertions::assert_eq;

    #[test]
    fn test_part_1() {
        assert_eq!(part_1(include_str!("inputs/day_19_example_1")), 19114);
        assert_eq!(part_1(include_str!("inputs/day_19")), 342650);
    }

    #[test]
    fn test_part_2() {
        // assert_eq!(
        //     part_2(include_str!("inputs/day_19_example_1")),
        //     952408144115
        // );
        // assert_eq!(part_2(include_str!("inputs/day_19")), 57196493937398);
    }
}
