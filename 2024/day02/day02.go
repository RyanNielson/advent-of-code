package day02

import (
	"aoc2024/utils"
	"slices"
	"strconv"
	"strings"
)

func Part1(inputPath string) int {
	reports := utils.Lines(inputPath)

	count := 0
	for _, report := range reports {
		levelStrings := strings.Fields(report)
		var levels []int
		for _, level := range levelStrings {
			level, _ := strconv.Atoi(level)
			levels = append(levels, level)
		}

		if (allIncreasing(levels) || allDecreasing(levels)) && differByCorrectAmount(levels) {
			count++
		}
	}

	return count
}

func allIncreasing(levels []int) bool {
	previousLevel := levels[0]
	for _, level := range levels[1:] {
		if previousLevel >= level {
			return false
		}

		previousLevel = level
	}

	return true
}

func allDecreasing(levels []int) bool {
	slices.Reverse(levels)
	return allIncreasing(levels)
}

func differByCorrectAmount(levels []int) bool {
	previousLevel := levels[0]
	for _, level := range levels[1:] {
		difference := utils.AbsInt(previousLevel - level)
		if difference < 1 || difference > 3 {
			return false
		}

		previousLevel = level
	}

	return true
}
