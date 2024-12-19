package day19

import (
	"aoc2024/utils"
	"strings"
)

func Part1(inputPath string) int {
	patterns, designs := parse(inputPath)

	possibleDesignsCount := 0
	for _, design := range designs {
		if isDesignPossible(design, patterns) {
			possibleDesignsCount++
		}
	}

	return possibleDesignsCount
}

func isDesignPossible(design string, patterns []string) bool {
	if design == "" {
		return true
	}

	patternsToCheck := possiblePatterns(design, patterns)
	if len(patternsToCheck) == 0 {
		return false
	}

	for _, pattern := range patternsToCheck {
		if isDesignPossible(strings.TrimPrefix(design, pattern), patterns) {
			return true
		}
	}

	return false
}

func possiblePatterns(design string, patterns []string) []string {
	possible := []string{}

	for _, pattern := range patterns {
		if strings.HasPrefix(design, pattern) {
			possible = append(possible, pattern)
		}
	}

	return possible
}

func Part2(inputPath string) int {
	return 0
}

func parse(inputPath string) (patterns []string, designs []string) {
	input := utils.FileText(inputPath)
	inputSections := strings.Split(input, "\n\n")

	return strings.Split(inputSections[0], ", "), strings.Split(inputSections[1], "\n")
}
