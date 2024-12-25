package day25

import (
	"aoc2024/utils"
	"strings"
)

func Part1(inputPath string) int {
	locks, keys := parse(inputPath)

	fitCount := 0
	for _, lock := range locks {
		for _, key := range keys {
			fit := true
			for i := 0; i < 5; i++ {
				if lock[i]+key[i] > 5 {
					fit = false
					break
				}
			}

			if fit {
				fitCount++
			}
		}
	}

	return fitCount
}

func parse(inputPath string) ([][]int, [][]int) {
	input := utils.FileText(inputPath)
	chunks := strings.Split(input, "\n\n")

	locks := [][]int{}
	keys := [][]int{}

	for _, chunk := range chunks {
		lines := strings.Split(chunk, "\n")
		heights := []int{-1, -1, -1, -1, -1}
		for _, line := range lines {
			for i := 0; i < 5; i++ {
				if line[i] == '#' {
					heights[i]++
				}
			}
		}

		if lines[0] == "#####" && lines[6] == "....." {
			locks = append(locks, heights)
		} else if lines[0] == "....." && lines[6] == "#####" {
			keys = append(keys, heights)
		}
	}

	return locks, keys
}
