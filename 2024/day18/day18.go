package day18

import (
	"aoc2024/utils"
	"fmt"
	"strconv"
)

type Coord struct {
	x, y int
}

type CoordSet map[Coord]struct{}

func (c CoordSet) Add(coord Coord) {
	c[coord] = struct{}{}
}

func (c CoordSet) Contains(coord Coord) bool {
	_, found := c[coord]
	return found
}

func Part1(inputPath string, max int, bytes int) int {
	coords := parse(inputPath)
	memory := initialize(coords, bytes)

	return bfs(memory, Coord{max, max})
}

func Part2(inputPath string, max int, finalByte int) string {
	coords := parse(inputPath)

	for i := finalByte; i < len(coords); i++ {
		memory := initialize(coords, i)

		steps := bfs(memory, Coord{max, max})
		if steps == 0 {
			coord := coords[i-1]
			return strconv.Itoa(coord.x) + "," + strconv.Itoa(coord.y)
		}
	}

	return "NOTFOUND"
}

func bfs(memory CoordSet, goal Coord) int {
	root := Coord{0, 0}
	visited := CoordSet{}
	queue := []Coord{root}
	visited.Add(root)
	steps := make(map[Coord]int)
	steps[root] = 0

	for len(queue) > 0 {
		v := queue[0]
		queue = queue[1:]

		if v == goal {
			return steps[v]
		}

		right := Coord{v.x + 1, v.y}
		left := Coord{v.x - 1, v.y}
		down := Coord{v.x, v.y + 1}
		up := Coord{v.x, v.y - 1}

		if right.x >= 0 && right.x <= goal.x && !memory.Contains(right) && !visited.Contains(right) {
			visited.Add(right)
			queue = append(queue, right)
			steps[right] = steps[v] + 1
		}
		if left.x >= 0 && left.x <= goal.x && !memory.Contains(left) && !visited.Contains(left) {
			visited.Add(left)
			queue = append(queue, left)
			steps[left] = steps[v] + 1
		}
		if down.y >= 0 && down.y <= goal.y && !memory.Contains(down) && !visited.Contains(down) {
			visited.Add(down)
			queue = append(queue, down)
			steps[down] = steps[v] + 1
		}
		if up.y >= 0 && up.y <= goal.y && !memory.Contains(up) && !visited.Contains(up) {
			visited.Add(up)
			queue = append(queue, up)
			steps[up] = steps[v] + 1
		}
	}
	return 0
}

func initialize(coords []Coord, bytes int) CoordSet {
	grid := make(CoordSet)

	for i, coord := range coords {
		if i == bytes {
			break
		}

		grid.Add(coord)
	}

	return grid
}

func parse(inputPath string) []Coord {
	lines := utils.FileLines(inputPath)
	coords := []Coord{}

	for _, line := range lines {
		var x, y int
		fmt.Sscanf(line, "%d,%d", &x, &y)
		coords = append(coords, Coord{x, y})
	}

	return coords
}
