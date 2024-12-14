package day14

import (
	"aoc2024/utils"
	"fmt"
	"strings"
)

type Robot struct {
	x  int
	y  int
	vx int
	vy int
}

type Space struct {
	width  int
	height int
	robots []Robot
}

func (s *Space) move(steps int) {
	for i := 0; i < steps; i++ {
		for i := range s.robots {
			robot := &s.robots[i]
			robot.x += robot.vx
			robot.y += robot.vy

			// This may or may not handle wrapping properly in all cases
			if robot.x < 0 {
				robot.x += s.width
			}
			if robot.x >= s.width {
				robot.x -= s.width
			}
			if robot.y < 0 {
				robot.y += s.height
			}
			if robot.y >= s.height {
				robot.y -= s.height
			}
		}
	}
}

func (s Space) safetyFactor() int {
	midX, midY := s.width/2, s.height/2

	var quadrant1, quadrant2, quadrant3, quadrant4 int

	for _, robot := range s.robots {
		if robot.x == midX || robot.y == midY {
			continue
		}

		if robot.x < midX && robot.y < midY {
			quadrant1 += 1
		} else if robot.x > midX && robot.y < midY {
			quadrant2 += 1
		} else if robot.x < midX && robot.y > midY {
			quadrant3 += 1
		} else if robot.x > midX && robot.y > midY {
			quadrant4 += 1
		}
	}

	return quadrant1 * quadrant2 * quadrant3 * quadrant4
}

func (s *Space) draw(iteration int) {
	positions := Set{}
	for _, robot := range s.robots {
		positions.Add(Position{robot.x, robot.y})
	}

	var sb strings.Builder
	sb.WriteString(fmt.Sprintf("Iteration: %d", iteration))

	for y := range s.height {
		for x := range s.width {
			hasRobot := positions.Contains(Position{x, y})

			if hasRobot {
				sb.WriteString("#")
			} else {
				sb.WriteString(" ")
			}
		}

		sb.WriteString("\n")
	}

	fmt.Println(sb.String())
}

type Position struct {
	x, y int
}

type Set map[Position]struct{}

func (s Set) Add(position Position) {
	s[position] = struct{}{}
}

func (s Set) Contains(position Position) bool {
	_, found := s[position]
	return found
}

func Part1(inputPath string, width, height int) int {
	lines := utils.FileLines(inputPath)
	robots := make([]Robot, 0)
	for _, line := range lines {
		var x, y, vx, vy int
		fmt.Sscanf(line, "p=%d,%d v=%d,%d", &x, &y, &vx, &vy)
		robots = append(robots, Robot{x, y, vx, vy})
	}

	space := Space{width, height, robots}
	space.move(100)

	return space.safetyFactor()
}

func Part2(inputPath string, width, height int) {
	lines := utils.FileLines(inputPath)
	robots := make([]Robot, 0)
	for _, line := range lines {
		var x, y, vx, vy int
		fmt.Sscanf(line, "p=%d,%d v=%d,%d", &x, &y, &vx, &vy)
		robots = append(robots, Robot{x, y, vx, vy})
	}

	space := Space{width, height, robots}
	i := 0
	for {
		space.draw(i)
		space.move(1)
		i++
	}
}
