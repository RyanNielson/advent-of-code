package day15

import (
	"aoc2024/utils"
	"fmt"
	"strings"
)

type Position struct {
	x, y int
}

type Grid struct {
	elements      map[Position]string
	robotPosition Position
	size          Position
}

func newGrid() Grid {
	return Grid{
		elements:      make(map[Position]string),
		robotPosition: Position{},
		size:          Position{},
	}
}

func (g *Grid) add(position Position, value string) {
	g.elements[position] = value

	newSize := g.size
	if position.x > g.size.x {
		newSize.x = position.x
	}
	if position.y > g.size.y {
		newSize.y = position.y
	}

	g.size = newSize
}

func (g *Grid) set(position Position, value string) {
	g.elements[position] = value
}

func (g *Grid) setRobotPosition(position Position) {
	g.robotPosition = position
}

func (g *Grid) get(position Position) (string, bool) {
	v, ok := g.elements[position]
	return v, ok
}

func (g *Grid) contains(position Position) bool {
	_, found := g.elements[position]
	return found
}

func (g *Grid) delete(position Position) {
	delete(g.elements, position)
}

func (g *Grid) moveRobot(direction Position) {
	checkPosition := Position{g.robotPosition.x + direction.x, g.robotPosition.y + direction.y}
	value, found := g.get(checkPosition)

	if found {
		if value == "O" {
			if direction.x == 1 {
				for x := checkPosition.x + 1; x < g.size.x+1; x++ {
					newPositionToCheck := Position{x, checkPosition.y}
					hitValue, hit := g.get(newPositionToCheck)
					if !hit {
						for x1 := x; x > checkPosition.x; x-- {
							g.set(Position{x1, checkPosition.y}, "O")
						}

						g.delete(checkPosition)
						g.robotPosition = checkPosition

						break
					} else if hitValue == "#" {
						break
					}
				}
			} else if direction.x == -1 {
				for x := checkPosition.x - 1; x >= 0; x-- {
					newPositionToCheck := Position{x, checkPosition.y}
					hitValue, hit := g.get(newPositionToCheck)
					if !hit {
						for x1 := x; x < checkPosition.x; x++ {
							g.set(Position{x1, checkPosition.y}, "O")
						}

						g.delete(checkPosition)
						g.robotPosition = checkPosition

						break
					} else if hitValue == "#" {
						break
					}
				}
			} else if direction.y == -1 {
				for y := checkPosition.y - 1; y >= 0; y-- {
					newPositionToCheck := Position{checkPosition.x, y}
					hitValue, hit := g.get(newPositionToCheck)
					if !hit {
						for y1 := y; y < checkPosition.y; y++ {
							g.set(Position{checkPosition.x, y1}, "O")
						}

						g.delete(checkPosition)
						g.robotPosition = checkPosition

						break
					} else if hitValue == "#" {
						break
					}
				}
			} else if direction.y == 1 {
				for y := checkPosition.y + 1; y < g.size.y+1; y++ {
					newPositionToCheck := Position{checkPosition.x, y}
					hitValue, hit := g.get(newPositionToCheck)
					if !hit {
						for y1 := y; y > checkPosition.y; y-- {
							g.set(Position{checkPosition.x, y1}, "O")
						}

						g.delete(checkPosition)
						g.robotPosition = checkPosition

						break
					} else if hitValue == "#" {
						break
					}
				}
			}
		}
	} else {
		g.robotPosition = checkPosition
	}
}

func (g *Grid) draw(movement string) {
	var sb strings.Builder
	sb.WriteString(fmt.Sprintf("Move: %s:\n", movement))

	for y := 0; y < g.size.y+1; y++ {
		for x := 0; x < g.size.x+1; x++ {
			if g.robotPosition.x == x && g.robotPosition.y == y {
				sb.WriteString("@")
				continue
			}
			value, found := g.get(Position{x, y})
			if found {
				sb.WriteString(value)
			} else {
				sb.WriteString(".")
			}
		}
		sb.WriteString("\n")
	}

	fmt.Println(sb.String())
}

func (g *Grid) boxCoordinatesSum() int {
	sum := 0
	for position, value := range g.elements {
		if value == "O" {
			sum += 100*position.y + position.x
		}
	}

	return sum
}

func Part1(inputPath string) int {
	grid, movements := parse(inputPath)

	for _, movement := range movements {
		moveDirection := Position{}
		if movement == "<" {
			moveDirection = Position{-1, 0}
		} else if movement == ">" {
			moveDirection = Position{1, 0}
		} else if movement == "^" {
			moveDirection = Position{0, -1}
		} else if movement == "v" {
			moveDirection = Position{0, 1}
		}

		grid.moveRobot(moveDirection)
	}

	return grid.boxCoordinatesSum()
}

func Part2(inputPath string) int {
	return 0
}

func parse(inputPath string) (Grid, []string) {
	input := utils.FileText(inputPath)

	configSections := strings.Split(input, "\n\n")

	grid := newGrid()
	for y, line := range strings.Split(configSections[0], "\n") {
		for x, value := range strings.Split(line, "") {
			if value == "@" {
				grid.setRobotPosition(Position{x, y})
			} else if value == "#" || value == "O" {
				grid.add(Position{x, y}, value)
			}
		}
	}

	movements := strings.Split(configSections[1], "")

	return grid, movements
}
