package day23

import (
	"aoc2024/utils"
	"fmt"
	"slices"
	"strings"
)

type Connections map[string]Set

func (c Connections) add(first, second string) {
	firstSet, firstFound := c[first]
	if firstFound {
		firstSet.add(second)
	} else {
		c[first] = Set{}
		c[first].add(second)
	}

	secondSet, secondFound := c[second]
	if secondFound {
		secondSet.add(first)
	} else {
		c[second] = Set{}
		c[second].add(first)
	}
}

type Set map[string]struct{}

func (s Set) add(name string) {
	s[name] = struct{}{}
}

func (s Set) contains(name string) bool {
	_, found := s[name]
	return found
}

func Part1(inputPath string) int {
	connections := parse(inputPath)

	// interconnectedComputers := []Set{}
	interconnections := []string{}
	for computer1, connectedComputers := range connections {
		for computer2 := range connectedComputers {
			for computer3 := range connections[computer2] {
				if connections[computer3].contains(computer1) {
					// interconnected := []string{computer1, computer2, computer3}
					// slices.Sort(interconnected)
					// interconnections = append(interconnections, fmt.Sprintf("%s,%s,%s", interconnected[0], interconnected[1], interconnected[2]))

					// Only those that start with t
					if strings.HasPrefix(computer1, "t") || strings.HasPrefix(computer2, "t") || strings.HasPrefix(computer3, "t") {
						interconnected := []string{computer1, computer2, computer3}
						slices.Sort(interconnected)
						interconnections = append(interconnections, fmt.Sprintf("%s,%s,%s", interconnected[0], interconnected[1], interconnected[2]))
					}

					// interconnections
					// fmt.Println(interconnected)

					// sort.Slice(interconnected, func(a, b string) bool {
					// 	return a > b
					// })
					// interconnected := Set{}
					// interconnected.add(computer1)
					// interconnected.add(computer2)
					// interconnected.add(computer3)
					// fmt.Println(interconnected)
					// sort.Slice()
					// Only add if doesn't already exists in array? Could also maybe be a set itself.

					// fmt.Printf("%s,%s,%s\n", computer1, computer2, computer3)
				}
			}
		}
	}

	slices.Sort(interconnections)
	slices.Compact(interconnections)

	validInterconnections := []string{}
	for _, interconnection := range interconnections {
		if interconnection != "" {
			validInterconnections = append(validInterconnections, interconnection)
		}
	}
	return len(validInterconnections)
}

func parse(inputPath string) Connections {
	lines := utils.FileLines(inputPath)

	connections := make(Connections)
	for _, line := range lines {
		parts := strings.Split(line, "-")
		connections.add(parts[0], parts[1])
	}

	return connections
}
