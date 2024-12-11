package day11

import (
	"aoc2024/utils"
	"strconv"
	"strings"
)

func Part1(inputPath string) int {
	stones := parse(inputPath)
	for i := 0; i < 25; i++ {
		stones = blink(stones)
	}

	return len(stones)
}

func Part2(inputPath string) int {
	return 0
}

func blink(stones []string) []string {
	var newStones []string

	for _, stone := range stones {
		if stone == "0" {
			newStones = append(newStones, "1")
		} else if len(stone)%2 == 0 {
			half := len(stone) / 2
			left := stone[:half]
			rightNumber, _ := strconv.Atoi(stone[half:])
			newStones = append(newStones, left, strconv.Itoa(rightNumber))
		} else {
			number, _ := strconv.Atoi(stone)
			newStones = append(newStones, strconv.Itoa(number*2024))
		}
	}

	return newStones
}

func parse(inputPath string) []string {
	input := utils.FileText(inputPath)
	return strings.Fields(input)
}
