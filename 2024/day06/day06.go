package day06

import (
	"aoc2024/utils"
)

type Position struct {
	X, Y int
}

type Set map[Position]struct{}

func (s Set) Add(value Position) {
	s[value] = struct{}{}
}

type Guard struct {
	Position  Position
	Direction Position
}

func (g *Guard) Rotate(grid Grid) {
	up, right, down, left := Position{0, -1}, Position{1, 0}, Position{0, 1}, Position{-1, 0}

	positionToCheck := Position{
		g.Position.X + g.Direction.X,
		g.Position.Y + g.Direction.Y,
	}

	if character, _ := grid.Get(positionToCheck); character == "#" {
		if g.Direction == up {
			g.Direction = right
			g.Rotate(grid)
		} else if g.Direction == right {
			g.Direction = down
			g.Rotate(grid)
		} else if g.Direction == down {
			g.Direction = left
			g.Rotate(grid)
		} else if g.Direction == left {
			g.Direction = up
			g.Rotate(grid)
		}
	}
}

func (g *Guard) Step(grid Grid) {
	g.Position = Position{
		g.Position.X + g.Direction.X,
		g.Position.Y + g.Direction.Y,
	}
}

type Grid map[Position]string

func (g Grid) Get(position Position) (string, bool) {
	v, ok := g[position]

	return v, ok
}

func (g Grid) Set(position Position, value string) {
	g[position] = value
}

func Part1(inputPath string) int {
	characters := utils.FileCharacters(inputPath)
	grid, guard := initialize(characters)

	visitedPositions := Set{}
	for {
		if _, exists := grid.Get(guard.Position); !exists {
			break
		}

		visitedPositions.Add(guard.Position)
		guard.Rotate(grid)
		guard.Step(grid)
	}

	return len(visitedPositions)
}

func initialize(characters [][]string) (Grid, Guard) {
	grid := Grid{}
	var guard Guard
	for y, line := range characters {
		for x, character := range line {
			if character == "^" {
				guard = Guard{
					Position:  Position{x, y},
					Direction: Position{0, -1},
				}
				grid.Set(Position{x, y}, ".")
			} else {
				grid.Set(Position{x, y}, character)
			}
		}
	}

	return grid, guard
}

func Part2(inputPath string) int {
	return 0
}
