package day04

import (
	"aoc2024/utils"
)

type Key struct {
	X, Y int
}

type WordSearch map[Key]string

func (w WordSearch) Get(x, y int) string {
	return w[Key{x, y}]
}

func (w WordSearch) Set(x, y int, value string) {
	w[Key{x, y}] = value
}

func Part1(inputPath string) int {
	characters := utils.FileCharacters(inputPath)
	wordSearch, maxX, maxY := newWordSearch(characters)

	return countWithFunc(maxX, maxY, wordSearch, xmasStartingAt)
}

func Part2(inputPath string) int {
	characters := utils.FileCharacters(inputPath)
	wordSearch, maxX, maxY := newWordSearch(characters)

	return countWithFunc(maxX, maxY, wordSearch, crossesStartingAt)
}

func countWithFunc(maxX, maxY int, wordSearch WordSearch, counter func(int, int, WordSearch) int) int {
	count := 0
	for y := range maxY + 1 {
		for x := range maxX + 1 {
			count += counter(x, y, wordSearch)
		}
	}

	return count
}

func newWordSearch(characters [][]string) (WordSearch, int, int) {
	wordSearch := WordSearch{}
	maxY, maxX := 0, 0
	for y, line := range characters {
		maxY = y
		for x, character := range line {
			wordSearch.Set(y, x, character)
			maxX = x
		}
	}
	return wordSearch, maxX, maxY
}

func crossesStartingAt(x, y int, wordSearch WordSearch) int {
	count := 0

	if wordSearch.Get(x, y) == "M" && wordSearch.Get(x+1, y+1) == "A" && wordSearch.Get(x+2, y+2) == "S" && wordSearch.Get(x, y+2) == "M" && wordSearch.Get(x+2, y) == "S" {
		count += 1
	}

	if wordSearch.Get(x, y) == "M" && wordSearch.Get(x+1, y+1) == "A" && wordSearch.Get(x+2, y+2) == "S" && wordSearch.Get(x, y+2) == "S" && wordSearch.Get(x+2, y) == "M" {
		count += 1
	}

	if wordSearch.Get(x, y) == "S" && wordSearch.Get(x+1, y+1) == "A" && wordSearch.Get(x+2, y+2) == "M" && wordSearch.Get(x, y+2) == "M" && wordSearch.Get(x+2, y) == "S" {
		count += 1
	}

	if wordSearch.Get(x, y) == "S" && wordSearch.Get(x+1, y+1) == "A" && wordSearch.Get(x+2, y+2) == "M" && wordSearch.Get(x, y+2) == "S" && wordSearch.Get(x+2, y) == "M" {
		count += 1
	}

	return count
}

func xmasStartingAt(x, y int, wordSearch WordSearch) int {
	count := 0

	if wordSearch.Get(x, y) != "X" {
		return count
	}

	if wordSearch.Get(x+1, y) == "M" && wordSearch.Get(x+2, y) == "A" && wordSearch.Get(x+3, y) == "S" {
		count += 1
	}

	if wordSearch.Get(x-1, y) == "M" && wordSearch.Get(x-2, y) == "A" && wordSearch.Get(x-3, y) == "S" {
		count += 1
	}

	if wordSearch.Get(x, y-1) == "M" && wordSearch.Get(x, y-2) == "A" && wordSearch.Get(x, y-3) == "S" {
		count += 1
	}

	if wordSearch.Get(x, y+1) == "M" && wordSearch.Get(x, y+2) == "A" && wordSearch.Get(x, y+3) == "S" {
		count += 1
	}

	if wordSearch.Get(x+1, y-1) == "M" && wordSearch.Get(x+2, y-2) == "A" && wordSearch.Get(x+3, y-3) == "S" {
		count += 1
	}

	if wordSearch.Get(x-1, y+1) == "M" && wordSearch.Get(x-2, y+2) == "A" && wordSearch.Get(x-3, y+3) == "S" {
		count += 1
	}

	if wordSearch.Get(x+1, y+1) == "M" && wordSearch.Get(x+2, y+2) == "A" && wordSearch.Get(x+3, y+3) == "S" {
		count += 1
	}

	if wordSearch.Get(x-1, y-1) == "M" && wordSearch.Get(x-2, y-2) == "A" && wordSearch.Get(x-3, y-3) == "S" {
		count += 1
	}

	return count
}
