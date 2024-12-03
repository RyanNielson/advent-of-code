package day03

import (
	"aoc2024/utils"
	"fmt"
	"regexp"
)

func Part1(inputPath string) int {
	regex := regexp.MustCompile(`mul\(\d+,\d+\)`)
	text := utils.FileText(inputPath)
	matches := regex.FindAllString(text, -1)

	sum := 0
	for _, match := range matches {
		var a, b int
		fmt.Sscanf(match, "mul(%d,%d)", &a, &b)
		sum += a * b
	}

	return sum
}

func Part2(inputPath string) int {
	regex := regexp.MustCompile(`mul\(\d+,\d+\)|do\(\)|don't\(\)`)
	text := utils.FileText(inputPath)
	matches := regex.FindAllString(text, -1)

	sum := 0
	enabled := true
	for _, match := range matches {
		if match == "do()" {
			enabled = true
		} else if match == "don't()" {
			enabled = false
		} else if enabled {
			var a, b int
			fmt.Sscanf(match, "mul(%d,%d)", &a, &b)
			sum += a * b
		}
	}

	return sum
}
