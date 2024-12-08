package day07

import (
	"aoc2024/utils"
	"strconv"
	"strings"
)

func Part1(inputPath string) int {
	equations := parse(inputPath)

	result := 0
	for _, equation := range equations {
		if valid(equation[0], equation[1:], 0) {
			result += equation[0]
		}
	}

	return result
}

func Part2(inputPath string) int {
	equations := parse(inputPath)

	result := 0
	for _, equation := range equations {
		if valid2(equation[0], equation[1:], 0) {
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

	return valid(value, numbers[1:], acc+numbers[0]) ||
		valid(value, numbers[1:], acc*numbers[0])
}

func valid2(value int, numbers []int, acc int) bool {
	if len(numbers) == 0 {
		return value == acc
	}

	if acc > value {
		return false
	}

	return valid2(value, numbers[1:], acc+numbers[0]) ||
		valid2(value, numbers[1:], acc*numbers[0]) ||
		valid2(value, numbers[1:], concatenate(acc, numbers[0]))
}

func concatenate(num1, num2 int) int {
	num1_str := strconv.Itoa(num1)
	num2_str := strconv.Itoa(num2)

	concatenated, _ := strconv.Atoi(num1_str + num2_str)
	return concatenated
}

func parse(inputPath string) [][]int {
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

	return equations
}
