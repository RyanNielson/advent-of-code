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
		// slices.Replace(string, start, end, []string)
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
	characters := utils.FileCharacters(inputPath)[0]
	var numbers []int
	for _, character := range characters {
		num, _ := strconv.Atoi(character)
		numbers = append(numbers, num)
	}

	var blocks []string
	id := 0
	isFile := true
	highestFileNumber := 0
	for _, number := range numbers {
		if isFile {
			idString := strconv.Itoa(id)
			for i := 0; i < number; i++ {
				blocks = append(blocks, idString)
			}
			highestFileNumber = id
			id += 1
		} else {
			for i := 0; i < number; i++ {
				blocks = append(blocks, ".")
			}
		}

		isFile = !isFile
	}

	for highest := highestFileNumber; highest >= 0; highest-- {
		highestFileNumberString := strconv.Itoa(highest)
		fileStart := slices.Index(blocks, highestFileNumberString)
		fileEnd := fileStart
		for i := fileStart; i < len(blocks); i++ {
			if blocks[i] == highestFileNumberString {
				fileEnd = i
			} else {
				break
			}
		}

		fileBlocksSlice := blocks[fileStart : fileEnd+1]
		fileBlocksSize := len(fileBlocksSlice)

		count := 0
		emptyEndIndex := -1
		for i, block := range blocks {
			if block == "." {
				count += 1
			} else {
				count = 0
			}

			if fileBlocksSize == count {
				emptyEndIndex = i
				break
			}
		}

		if emptyEndIndex == -1 {
			continue
		}

		emptyStart := emptyEndIndex - fileBlocksSize + 1

		if emptyStart > fileStart {
			continue
		}

		for i := 0; i < fileBlocksSize; i++ {
			emptyValue := blocks[emptyStart+i]
			fileValue := blocks[fileStart+i]

			blocks[emptyStart+i] = fileValue
			blocks[fileStart+i] = emptyValue
		}
	}

	checksum := 0
	for i, block := range blocks {
		blockInt, _ := strconv.Atoi(block)
		checksum += i * blockInt
	}

	return checksum
}
