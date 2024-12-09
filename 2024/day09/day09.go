package day09

import (
	"aoc2024/utils"
	"slices"
	"strconv"
)

func Part1(inputPath string) int {
	characters := utils.FileCharacters(inputPath)[0]
	var numbers []int
	for _, character := range characters {
		num, _ := strconv.Atoi(character)
		numbers = append(numbers, num)
	}

	var blocks []string
	id := 0
	isFile := true
	for _, number := range numbers {
		if isFile {
			idString := strconv.Itoa(id)
			for i := 0; i < number; i++ {
				blocks = append(blocks, idString)
			}

			id += 1
		} else {
			for i := 0; i < number; i++ {
				blocks = append(blocks, ".")
			}
		}

		isFile = !isFile
	}

	for {
		firstEmptyIndex := slices.Index(blocks, ".")
		var lastFileBlockIndex int
		for i := len(blocks) - 1; i >= 0; i-- {
			if blocks[i] != "." {
				lastFileBlockIndex = i
				break
			}
		}

		if firstEmptyIndex > lastFileBlockIndex {
			break
		}

		firstValue := blocks[firstEmptyIndex]
		lastValue := blocks[lastFileBlockIndex]

		blocks[firstEmptyIndex] = lastValue
		blocks[lastFileBlockIndex] = firstValue
	}

	checksum := 0
	for i, block := range blocks {
		blockInt, _ := strconv.Atoi(block)
		checksum += i * blockInt
	}

	return checksum
}

func Part2(inputPath string) int {
	return 0
}
