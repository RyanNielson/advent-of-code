package day12

import (
	"aoc2024/utils"
)

type Position struct {
	x, y int
}

type Set map[Position]struct{}

func (s Set) Add(position Position) {
	s[position] = struct{}{}
}

func (s Set) Remove(position Position) {
	s[position] = struct{}{}
}

func (s Set) Contains(position Position) bool {
	_, found := s[position]
	return found
}

func Part1(inputPath string) int {
	characters := utils.FileCharacters(inputPath)
	positionsByCharacter := make(map[string][]Position)
	for y, row := range characters {
		for x, character := range row {
			positionsByCharacter[character] = append(positionsByCharacter[character], Position{x, y})
		}
	}

	totalPrice := 0
	for _, positions := range positionsByCharacter {
		regions := determineRegions(positions)
		for _, region := range regions {
			area := len(region)
			perimeter := determinePerimeter(region)
			totalPrice += area * perimeter
		}
	}

	return totalPrice
}

func determinePerimeter(positions Set) int {
	edgeCount := 0

	for position := range positions {
		right := Position{position.x + 1, position.y}
		left := Position{position.x - 1, position.y}
		down := Position{position.x, position.y + 1}
		up := Position{position.x, position.y - 1}

		if !positions.Contains(right) {
			edgeCount++
		}
		if !positions.Contains(left) {
			edgeCount++
		}
		if !positions.Contains(down) {
			edgeCount++
		}
		if !positions.Contains(up) {
			edgeCount++
		}
	}

	return edgeCount
}

func traverseRegion(region Set, visited Set, positionSet Set, position Position) {
	right := Position{position.x + 1, position.y}
	left := Position{position.x - 1, position.y}
	down := Position{position.x, position.y + 1}
	up := Position{position.x, position.y - 1}

	if !visited.Contains(right) && positionSet.Contains(right) {
		visited.Add(right)
		region.Add(right)
		traverseRegion(region, visited, positionSet, right)
	}
	if !visited.Contains(left) && positionSet.Contains(left) {
		visited.Add(left)
		region.Add(left)
		traverseRegion(region, visited, positionSet, left)
	}
	if !visited.Contains(down) && positionSet.Contains(down) {
		visited.Add(down)
		region.Add(down)
		traverseRegion(region, visited, positionSet, down)
	}
	if !visited.Contains(up) && positionSet.Contains(up) {
		visited.Add(up)
		region.Add(up)
		traverseRegion(region, visited, positionSet, up)
	}
}

func determineRegions(positions []Position) []Set {
	visited := Set{}
	regions := []Set{}

	positionSet := make(Set)
	for _, position := range positions {
		positionSet.Add(position)
	}

	for _, position := range positions {
		if visited.Contains(position) {
			continue
		}

		visited.Add(position)

		region := Set{}
		region.Add(position)

		traverseRegion(region, visited, positionSet, position)

		regions = append(regions, region)
	}

	return regions
}
