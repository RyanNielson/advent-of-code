package day02

import (
	"aoc2024/utils"
	"slices"
	"strconv"
	"strings"
)

func Part1(inputPath string) int {
	reports := utils.FileLines(inputPath)

	count := 0
	for _, report := range reports {
		levels := parseReport(report)

		if (allIncreasing(levels) || allDecreasing(levels)) && differByCorrectAmount(levels) {
			count++
		}
	}

	return count
}

func Part2(inputPath string) int {
	reports := utils.FileLines(inputPath)

	count := 0
	for _, report := range reports {
		levels := parseReport(report)

		if (allIncreasing(levels) || allDecreasing(levels)) && differByCorrectAmount(levels) {
			count++
		} else {
			for i := 0; i < len(levels); i++ {
				var newLevels []int

				newLevels = append(newLevels, levels[:i]...)
				newLevels = append(newLevels, levels[i+1:]...)

				if (allIncreasing(newLevels) || allDecreasing(newLevels)) && differByCorrectAmount(newLevels) {
					count++
					break
				}
			}
		}
	}

	return count
}

func parseReport(report string) []int {
	levelStrings := strings.Fields(report)
	var levels []int
	for _, level := range levelStrings {
		level, _ := strconv.Atoi(level)
		levels = append(levels, level)
	}

	return levels
}

func allIncreasing(levels []int) bool {
	previousLevel := levels[0]
	for _, level := range levels[1:] {
		if previousLevel > level {
			return false
		}

		previousLevel = level
	}

	return true
}

func allDecreasing(levels []int) bool {
	levels = slices.Clone(levels)
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
