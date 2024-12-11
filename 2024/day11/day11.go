package day11

import (
	"aoc2024/utils"
	"strconv"
	"strings"
)

func Part1(inputPath string) int {
	return solve(inputPath, 25)
}

func Part2(inputPath string) int {
	return solve(inputPath, 75)
}

func solve(inputPath string, blinkTimes int) int {
	input := utils.FileText(inputPath)

	stones := make(map[int]int)
	for _, numberString := range strings.Fields(input) {
		number, _ := strconv.Atoi(numberString)
		stones[number] += 1
	}

	for i := 0; i < blinkTimes; i++ {
		stones = blink(stones)
	}

	totalCount := 0
	for _, count := range stones {
		totalCount += count
	}

	return totalCount
}

func blink(stones map[int]int) map[int]int {
	newStones := make(map[int]int)

	for stone, count := range stones {
		if stone == 0 {
			newStones[1] += count
		} else {
			if stoneString := strconv.Itoa(stone); len(stoneString)%2 == 0 {
				half := len(stoneString) / 2
				left, _ := strconv.Atoi(stoneString[:half])
				right, _ := strconv.Atoi(stoneString[half:])
				newStones[left] += count
				newStones[right] += count
			} else {
				newStones[stone*2024] += count
			}
		}
	}

	return newStones
}
