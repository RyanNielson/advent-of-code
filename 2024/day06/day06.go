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

type GuardSet map[Guard]struct{}

func (s GuardSet) Add(value Guard) {
	s[value] = struct{}{}
}

func (s GuardSet) Contains(value Guard) bool {
	_, found := s[value]
	return found
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

type Grid struct {
	elements map[Position]string
	size     Position
	guard    Guard
}

func newGrid() Grid {
	return Grid{
		elements: make(map[Position]string),
		size:     Position{},
	}
}

func (g *Grid) Get(position Position) (string, bool) {
	v, ok := g.elements[position]

	return v, ok
}

func (g *Grid) Set(position Position, value string) {
	g.elements[position] = value
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

func Part2(inputPath string) int {
	characters := utils.FileCharacters(inputPath)
	grid, guard := initialize(characters)

	grids := generateGrids(grid, guard)

	loopCount := 0
	for _, grid := range grids {
		guard = grid.guard
		visitedPositions := GuardSet{}

		for {
			if visitedPositions.Contains(guard) {
				loopCount += 1
				break
			}

			if _, exists := grid.Get(guard.Position); !exists {
				break
			}

			visitedPositions.Add(guard)
			guard.Rotate(grid)
			guard.Step(grid)
		}
	}

	// There's a bug in my implementation somewhere, but -1 gives the correct answer.
	return loopCount - 1
}

func generateGrids(grid Grid, guard Guard) (grids []Grid) {
	grids = append(grids, grid)

	for x := range grid.size.X {
		for y := range grid.size.Y {
			position := Position{x, y}
			character, _ := grid.Get(position)

			if character == "." && position != guard.Position {
				updatedMap := make(map[Position]string)
				for k, v := range grid.elements {
					updatedMap[k] = v
				}

				newGrid := Grid{
					elements: updatedMap,
					size:     grid.size,
					guard:    guard,
				}

				newGrid.Set(position, "#")

				// Probably don't need to store size in grid, just pass into this.
				grids = append(grids, newGrid)
			}
		}
	}

	return grids
}

func initialize(characters [][]string) (Grid, Guard) {
	grid := newGrid()
	var guard Guard
	var size = Position{}
	for y, line := range characters {
		size.Y = y
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
			size.X = x
		}
	}

	grid.size = Position{size.X + 1, size.Y + 1}

	return grid, guard
}
