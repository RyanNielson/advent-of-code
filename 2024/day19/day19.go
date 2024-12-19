package day19

import (
	"aoc2024/utils"
	"strings"
)

func Part1(inputPath string) int {
	patterns, designs := parse(inputPath)

	possibleDesignsCount := 0
	for _, design := range designs {
		if numPossibleDesigns(design, patterns, map[string]int{}) > 0 {
			possibleDesignsCount++
		}
	}

	return possibleDesignsCount
}

func Part2(inputPath string) int {
	patterns, designs := parse(inputPath)

	possibleDesignsCount := 0
	for _, design := range designs {
		possibleDesignsCount += numPossibleDesigns(design, patterns, map[string]int{})
	}

	return possibleDesignsCount
}

func numPossibleDesigns(design string, patterns []string, cache map[string]int) int {
	if value, found := cache[design]; found {
		return value
	}

	if design == "" {
		return 1
	}

	patternsToCheck := possiblePatterns(design, patterns)
	if len(patternsToCheck) == 0 {
		return 0
	}

	totalCount := 0
	for _, pattern := range patternsToCheck {
		totalCount += numPossibleDesigns(strings.TrimPrefix(design, pattern), patterns, cache)
	}

	cache[design] = totalCount
	return totalCount
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

func parse(inputPath string) (patterns []string, designs []string) {
	input := utils.FileText(inputPath)
	inputSections := strings.Split(input, "\n\n")

	return strings.Split(inputSections[0], ", "), strings.Split(inputSections[1], "\n")
}
