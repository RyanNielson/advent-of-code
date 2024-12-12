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

func (s Set) Contains(position Position) bool {
	_, found := s[position]
	return found
}

type NormalsToPositions map[Position]Set

func (m NormalsToPositions) Add(normal Position, position Position) {
	_, found := m[normal]

	if !found {
		m[normal] = make(Set)
	}
	// m[normal] = make(Set)
	m[normal].Add(position) // = append(m[normal], position)
}

func (s NormalsToPositions) Contains(normal Position, position Position) bool {
	positions, found := s[normal]

	if found {
		return positions.Contains(position)
	}

	return found
}

type Normals map[Position]Set

func (m Normals) Add(position Position, normal Position) {
	_, found := m[position]

	if !found {
		m[position] = make(Set)
	}
	m[position].Add(normal)
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

func Part2(inputPath string) int {
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
			sides := determineSides(region)
			totalPrice += area * sides
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

func determineSides(positions Set) int {
	normals := make(Normals)

	for position := range positions {
		right := Position{position.x + 1, position.y}
		left := Position{position.x - 1, position.y}
		down := Position{position.x, position.y + 1}
		up := Position{position.x, position.y - 1}

		if !positions.Contains(right) {
			normals.Add(position, Position{1, 0})
		}
		if !positions.Contains(left) {
			normals.Add(position, Position{-1, 0})
		}
		if !positions.Contains(down) {
			normals.Add(position, Position{0, 1})
		}
		if !positions.Contains(up) {
			normals.Add(position, Position{0, -1})
		}
	}

	rightNormal := Position{1, 0}
	leftNormal := Position{-1, 0}
	downNormal := Position{0, 1}
	upNormal := Position{0, -1}
	cornerCount := 0
	// Outer corners
	for _, normals := range normals {
		// Up right corner
		if normals.Contains(rightNormal) && normals.Contains(upNormal) {
			cornerCount++
		}
		// Up left corner
		if normals.Contains(leftNormal) && normals.Contains(upNormal) {
			cornerCount++
		}

		// Down right corner
		if normals.Contains(rightNormal) && normals.Contains(downNormal) {
			cornerCount++
		}

		// Down left corner
		if normals.Contains(leftNormal) && normals.Contains(downNormal) {
			cornerCount++
		}
	}

	// Inner corners
	for position := range positions {
		right := Position{position.x + 1, position.y}
		left := Position{position.x - 1, position.y}
		down := Position{position.x, position.y + 1}
		up := Position{position.x, position.y - 1}
		upRight := Position{position.x + 1, position.y - 1}
		upLeft := Position{position.x - 1, position.y - 1}
		downRight := Position{position.x + 1, position.y + 1}
		downLeft := Position{position.x - 1, position.y + 1}

		// Top right
		if positions.Contains(up) && positions.Contains(right) && !positions.Contains(upRight) {
			cornerCount++
		}
		// Top left
		if positions.Contains(up) && positions.Contains(left) && !positions.Contains(upLeft) {
			cornerCount++
		}
		// Bottom right
		if positions.Contains(down) && positions.Contains(right) && !positions.Contains(downRight) {
			cornerCount++
		}
		// Bottom left
		if positions.Contains(down) && positions.Contains(left) && !positions.Contains(downLeft) {
			cornerCount++
		}
	}

	return cornerCount
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
