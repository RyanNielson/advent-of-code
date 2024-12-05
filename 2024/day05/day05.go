package day05

import (
	"aoc2024/utils"
	"slices"
	"strconv"
	"strings"
)

func Part1(inputPath string) int {
	return checkUpdates(inputPath, true)
}

func Part2(inputPath string) int {
	return checkUpdates(inputPath, false)
}

func checkUpdates(inputPath string, correct bool) int {
	lines := utils.FileLines(inputPath)

	rules := make(map[string][]string)
	var updates [][]string
	for _, line := range lines {
		if strings.Contains(line, "|") {
			sides := strings.Split(line, "|")

			if val, ok := rules[sides[0]]; ok {
				rules[sides[0]] = append(val, sides[1])
			} else {
				rules[sides[0]] = []string{sides[1]}
			}
		} else if strings.Contains(line, ",") {
			updates = append(updates, strings.Split(line, ","))
		}
	}

	compare := func(a, b string) int {
		for _, rule := range rules[a] {
			if rule == b {
				return -1
			}
		}

		return 0
	}

	result := 0
	for _, update := range updates {
		updateBeforeSort := utils.CopyStringSlice(update)
		slices.SortFunc(update, compare)

		num := 0
		if correct && slices.Equal(updateBeforeSort, update) {
			num, _ = strconv.Atoi(updateBeforeSort[len(updateBeforeSort)/2])
		} else if !correct && !slices.Equal(updateBeforeSort, update) {
			num, _ = strconv.Atoi(update[len(update)/2])
		}

		result += num
	}

	return result
}
