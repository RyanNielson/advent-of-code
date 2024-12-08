package day07

import (
	"aoc2024/utils"
	"strconv"
	"strings"
)

func Part1(inputPath string) int {
	lines := utils.FileLines(inputPath)

	var equations [][]int
	for _, line := range lines {
		pieces := strings.Fields(line)
		pieces[0] = strings.ReplaceAll(pieces[0], ":", "")

		var numbers []int
		for _, piece := range pieces {
			number, _ := strconv.Atoi(piece)
			numbers = append(numbers, number)
		}

		equations = append(equations, numbers)
	}

	result := 0
	for _, equation := range equations {
		if valid(equation[0], equation[1:], 0) {
			result += equation[0]
		}
	}

	return result
}

func valid(value int, numbers []int, acc int) bool {
	if len(numbers) == 0 {
		return value == acc
	}

	if acc > value {
		return false
	}

	return valid(value, numbers[1:], acc+numbers[0]) || valid(value, numbers[1:], acc*numbers[0])
}

func Part2(inputPath string) int {
	return 0
}
