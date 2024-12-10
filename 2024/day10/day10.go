package day10

import (
	"aoc2024/utils"
	"strconv"
)

type Position struct {
	x, y int
}

type TopographicMap map[Position]int
type Trailheads []Position

type Set map[Position]struct{}

func (s Set) Add(value Position) {
	s[value] = struct{}{}
}

func Part1(inputPath string) int {
	topographicMap, trailheads := parse(inputPath)

	scoreSum := 0
	for _, trailhead := range trailheads {
		ninesReached := Set{}
		step(topographicMap, trailhead, ninesReached)

		scoreSum += len(ninesReached)
	}

	return scoreSum
}

func Part2(inputPath string) int {
	topographicMap, trailheads := parse(inputPath)

	scoreSum := 0
	for _, trailhead := range trailheads {
		scoreSum += step(topographicMap, trailhead, Set{})
	}

	return scoreSum
}

func step(topographicMap TopographicMap, position Position, ninesReached Set) int {
	if positionValue := topographicMap[position]; positionValue == 9 {
		ninesReached.Add(position)
		return 1
	}

	reachablePositions := reachablePositions(topographicMap, position)

	if len(reachablePositions) == 0 {
		return 0
	}

	sum := 0
	for _, reachablePosition := range reachablePositions {
		sum += step(topographicMap, reachablePosition, ninesReached)
	}

	return sum
}

func reachablePositions(topographicMap TopographicMap, position Position) []Position {
	right := Position{position.x + 1, position.y}
	left := Position{position.x - 1, position.y}
	down := Position{position.x, position.y + 1}
	up := Position{position.x, position.y - 1}

	currentHeight := topographicMap[position]
	var reachablePositions []Position

	if pos, exists := topographicMap[right]; exists && currentHeight+1 == pos {
		reachablePositions = append(reachablePositions, right)
	}

	if pos, exists := topographicMap[left]; exists && currentHeight+1 == pos {
		reachablePositions = append(reachablePositions, left)
	}

	if pos, exists := topographicMap[down]; exists && currentHeight+1 == pos {
		reachablePositions = append(reachablePositions, down)
	}

	if pos, exists := topographicMap[up]; exists && currentHeight+1 == pos {
		reachablePositions = append(reachablePositions, up)
	}

	return reachablePositions
}

func parse(inputPath string) (TopographicMap, Trailheads) {
	topographicMap := TopographicMap{}
	trailheads := Trailheads{}
	characters := utils.FileCharacters(inputPath)
	for y, line := range characters {
		for x, character := range line {
			number, _ := strconv.Atoi(character)
			topographicMap[Position{x, y}] = number

			if number == 0 {
				trailheads = append(trailheads, Position{x, y})
			}
		}
	}

	return topographicMap, trailheads
}
