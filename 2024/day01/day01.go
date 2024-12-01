package day01

import (
	"aoc2024/utils"
	"slices"
	"strconv"
	"strings"
)

func Part1(inputPath string) int {
	lines := utils.Lines(inputPath)

	left, right := sides(lines)

	slices.Sort(left)
	slices.Sort(right)

	var distances []int
	for i, value := range left {
		distances = append(distances, utils.AbsInt(value-right[i]))
	}

	sum := 0
	for _, value := range distances {
		sum += value
	}

	return sum
}

func Part2(inputPath string) int {
	lines := utils.Lines(inputPath)

	left, right := sides(lines)

	score := 0
	for _, v1 := range left {
		count := 0
		for _, v2 := range right {
			if v1 == v2 {
				count += 1
			}
		}

		score += v1 * count
	}

	return score
}

func sides(lines []string) ([]int, []int) {
	var left []int
	var right []int
	for _, line := range lines {
		numbers := strings.Fields(line)
		num1, _ := strconv.Atoi(numbers[0])
		num2, _ := strconv.Atoi(numbers[1])

		left = append(left, num1)
		right = append(right, num2)
	}

	return left, right
}
