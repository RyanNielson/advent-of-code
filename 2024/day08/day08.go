package day08

import (
	"aoc2024/utils"
)

type Position struct {
	x int
	y int
}

type Antennas struct {
	elements map[string][]Position
	size     Position
}

func newAntennas() Antennas {
	return Antennas{
		elements: make(map[string][]Position),
		size:     Position{},
	}
}

func (a *Antennas) GetPositions(frequency string) []Position {
	return a.elements[frequency]
}

func (a *Antennas) AddPosition(frequency string, position Position) {
	if position.x >= 0 && position.x < a.size.x && position.y >= 0 && position.y < a.size.y {
		a.elements[frequency] = append(a.elements[frequency], position)
	}
}

func (a *Antennas) AddPositionUnbounded(frequency string, position Position) {
	a.elements[frequency] = append(a.elements[frequency], position)
}

func Part1(inputPath string) int {
	antennas := parse(inputPath)

	for frequency, positions := range antennas.elements {
		if frequency == "#" {
			continue
		}

		for i, position1 := range positions {
			for _, position2 := range positions[i+1:] {
				difference := Position{position1.x - position2.x, position1.y - position2.y}

				antennas.AddPosition("#", Position{position1.x + difference.x, position1.y + difference.y})
				antennas.AddPosition("#", Position{position2.x + (difference.x * -1), position2.y + (difference.y * -1)})
			}
		}
	}

	antinodePositions := make(map[Position]struct{}) //, map[Position]struct{}
	for _, antinodePosition := range antennas.elements["#"] {
		antinodePositions[antinodePosition] = struct{}{}
	}

	return len(antinodePositions)
}

func Part2(inputPath string) int {
	return 0
}

func parse(inputPath string) Antennas {
	characters := utils.FileCharacters(inputPath)
	antennas := newAntennas()
	maxY, maxX := 0, 0
	for y, line := range characters {
		maxY = y
		for x, character := range line {
			maxX = x
			if character != "." {
				antennas.AddPositionUnbounded(character, Position{x, y})
			}
		}
	}

	antennas.size = Position{maxX + 1, maxY + 1}

	return antennas
}
