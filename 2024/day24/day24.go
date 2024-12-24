package day24

import (
	"aoc2024/utils"
	"regexp"
	"sort"
	"strconv"
	"strings"
)

type GateConnection struct {
	input1 string
	gate   string
	input2 string
	output string
}

func Part1(inputPath string) int {
	wires, gateConnections := parse(inputPath)

	for i := 0; i < len(gateConnections); i++ {
		gateConnection := gateConnections[i]

		if wires[gateConnection.input1] == "" || wires[gateConnection.input2] == "" {
			gateConnections = append(gateConnections, gateConnection)
			continue
		}

		switch gateConnection.gate {
		case "AND":
			if wires[gateConnection.input1] == "1" && wires[gateConnection.input2] == "1" {
				wires[gateConnection.output] = "1"
			} else {
				wires[gateConnection.output] = "0"
			}
		case "OR":
			if wires[gateConnection.input1] == "1" || wires[gateConnection.input2] == "1" {
				wires[gateConnection.output] = "1"
			} else {
				wires[gateConnection.output] = "0"
			}
		case "XOR":
			if wires[gateConnection.input1] != wires[gateConnection.input2] {
				wires[gateConnection.output] = "1"
			} else {
				wires[gateConnection.output] = "0"
			}
		}
	}

	zWireKeys := []string{}
	for key := range wires {
		if strings.HasPrefix(key, "z") {
			zWireKeys = append(zWireKeys, key)
		}
	}

	sort.Sort(sort.Reverse(sort.StringSlice(zWireKeys)))

	var sb strings.Builder
	for _, zWireKey := range zWireKeys {
		sb.WriteString(wires[zWireKey])
	}

	decimal, _ := strconv.ParseInt(sb.String(), 2, 64)

	return int(decimal)
}

func parse(inputPath string) (map[string]string, []GateConnection) {
	input := utils.FileText(inputPath)
	inputSections := strings.Split(input, "\n\n")

	wires := make(map[string]string)
	initialValueRegex := regexp.MustCompile(`(\w+): (\d)`)
	for _, initialValueLine := range strings.Split(inputSections[0], "\n") {
		initialValueMatches := initialValueRegex.FindStringSubmatch(initialValueLine)
		wires[initialValueMatches[1]] = initialValueMatches[2]
	}

	gateConnectionRegex := regexp.MustCompile(`(\w+) (\w+) (\w+) -> (\w+)`)
	gateConnections := []GateConnection{}
	for _, gateConnectionLine := range strings.Split(inputSections[1], "\n") {
		gateConnectionMatches := gateConnectionRegex.FindStringSubmatch(gateConnectionLine)
		gateConnection := GateConnection{gateConnectionMatches[1], gateConnectionMatches[2], gateConnectionMatches[3], gateConnectionMatches[4]}
		gateConnections = append(gateConnections, gateConnection)
	}

	return wires, gateConnections
}
