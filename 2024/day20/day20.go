package day20

import (
	"aoc2024/utils"
)

type Coord struct {
	x, y int
}

type CoordSet map[Coord]struct{}

func (c CoordSet) Add(coord Coord) {
	c[coord] = struct{}{}
}

func (c CoordSet) Remove(coord Coord) {
	delete(c, coord)
}

func (c CoordSet) Contains(coord Coord) bool {
	_, found := c[coord]
	return found
}

// This takes ~30 seconds to run but it works.
// Can probably speed it up by shortcutting since we already know the distance from the start
// at each point. And when shortcutting you're always removing a wall adjacent to the track.
// So for each spot in the track, try to remove a wall from each side and subject the distance from the
// other side of the wall +1.
func Part1(inputPath string) int {
	walls, start, end, max := initialize(inputPath)

	base_time := bfs(walls, start, end, max)

	var times []int
	for wall, _ := range walls {
		walls.Remove(wall)

		time := bfs(walls, start, end, max)
		difference := base_time - time
		if difference >= 100 {
			times = append(times, base_time-time)
		}

		walls.Add(wall)
	}

	return len(times)
}

func bfs(walls CoordSet, start Coord, end Coord, max Coord) int {
	root := start
	visited := CoordSet{}
	queue := []Coord{root}
	visited.Add(root)
	steps := make(map[Coord]int)
	steps[root] = 0

	for len(queue) > 0 {
		v := queue[0]
		queue = queue[1:]

		if v == end {
			return steps[v]
		}

		right := Coord{v.x + 1, v.y}
		left := Coord{v.x - 1, v.y}
		down := Coord{v.x, v.y + 1}
		up := Coord{v.x, v.y - 1}

		if right.x >= 0 && right.x <= max.x && !walls.Contains(right) && !visited.Contains(right) {
			visited.Add(right)
			queue = append(queue, right)
			steps[right] = steps[v] + 1
		}
		if left.x >= 0 && left.x <= max.x && !walls.Contains(left) && !visited.Contains(left) {
			visited.Add(left)
			queue = append(queue, left)
			steps[left] = steps[v] + 1
		}
		if down.y >= 0 && down.y <= max.y && !walls.Contains(down) && !visited.Contains(down) {
			visited.Add(down)
			queue = append(queue, down)
			steps[down] = steps[v] + 1
		}
		if up.y >= 0 && up.y <= max.y && !walls.Contains(up) && !visited.Contains(up) {
			visited.Add(up)
			queue = append(queue, up)
			steps[up] = steps[v] + 1
		}
	}
	return 0
}

// func bfs(walls CoordSet, start Coord, end Coord, max Coord) map[Coord]int {
// 	root := start
// 	visited := CoordSet{}
// 	queue := []Coord{root}
// 	visited.Add(root)
// 	steps := make(map[Coord]int)
// 	steps[root] = 0

// 	for len(queue) > 0 {
// 		v := queue[0]
// 		queue = queue[1:]

// 		// if v == end {
// 		// 	return steps[v]
// 		// }

// 		fmt.Println(end)

// 		if v == end {
// 			return steps
// 		}

// 		right := Coord{v.x + 1, v.y}
// 		left := Coord{v.x - 1, v.y}
// 		down := Coord{v.x, v.y + 1}
// 		up := Coord{v.x, v.y - 1}

// 		if right.x >= 0 && right.x <= max.x && !walls.Contains(right) && !visited.Contains(right) {
// 			visited.Add(right)
// 			queue = append(queue, right)
// 			steps[right] = steps[v] + 1
// 		}
// 		if left.x >= 0 && left.x <= max.x && !walls.Contains(left) && !visited.Contains(left) {
// 			visited.Add(left)
// 			queue = append(queue, left)
// 			steps[left] = steps[v] + 1
// 		}
// 		if down.y >= 0 && down.y <= max.y && !walls.Contains(down) && !visited.Contains(down) {
// 			visited.Add(down)
// 			queue = append(queue, down)
// 			steps[down] = steps[v] + 1
// 		}
// 		if up.y >= 0 && up.y <= max.y && !walls.Contains(up) && !visited.Contains(up) {
// 			visited.Add(up)
// 			queue = append(queue, up)
// 			steps[up] = steps[v] + 1
// 		}
// 	}
// 	return steps
// }

func initialize(inputPath string) (CoordSet, Coord, Coord, Coord) {
	lines := utils.FileLines(inputPath)
	walls := make(CoordSet)

	var end, start Coord
	var maxX, maxY int
	for y, line := range lines {
		maxY = y
		for x, value := range line {
			maxX = x
			if value == '#' {
				walls.Add(Coord{x, y})
			} else if value == 'S' {
				start = Coord{x, y}
			} else if value == 'E' {
				end = Coord{x, y}
			}
		}
	}

	max := Coord{maxX, maxY}

	return walls, start, end, max
}
