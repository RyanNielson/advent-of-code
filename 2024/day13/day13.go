package day13

import (
	"aoc2024/utils"
	"math"
	"regexp"
	"strconv"
	"strings"
)

type Machine struct {
	aX     int
	aY     int
	bX     int
	bY     int
	prizeX int
	prizeY int
}

func Part1(inputPath string) int {
	return solve(inputPath, false)
}

func Part2(inputPath string) int {
	return solve(inputPath, true)
}

func solve(inputPath string, part2 bool) int {
	machines := parse(inputPath)

	tokens := 0
	for _, machine := range machines {
		prizeX, prizeY := machine.prizeX, machine.prizeY

		if part2 {
			prizeX += 10000000000000
			prizeY += 10000000000000
		}

		// Solve using Cramer's rule: https://en.wikipedia.org/wiki/Cramer%27s_rule
		determinateA := machine.aX*machine.bY - machine.bX*machine.aY
		determinateAi := prizeX*machine.bY - machine.bX*prizeY
		determinateB := machine.aX*machine.bY - machine.bX*machine.aY
		determinateBi := machine.aX*prizeY - prizeX*machine.aY

		_, frac := math.Modf(float64(determinateAi) / float64(determinateA))

		if frac != 0 {
			continue
		} else {
			a := determinateAi / determinateA
			b := determinateBi / determinateB

			tokens += 3*a + b
		}
	}

	return tokens
}

func parse(inputPath string) []Machine {
	input := utils.FileText(inputPath)

	machineConfigs := strings.Split(input, "\n\n")

	machines := make([]Machine, 0)
	for _, machineConfig := range machineConfigs {
		aRegex := regexp.MustCompile(`Button A: X\+(\d+), Y\+(\d+)`)
		bRegex := regexp.MustCompile(`Button B: X\+(\d+), Y\+(\d+)`)
		prizeRegex := regexp.MustCompile(`Prize: X=(\d+), Y=(\d+)`)

		aMatches := aRegex.FindStringSubmatch(machineConfig)
		aX, _ := strconv.Atoi(aMatches[1])
		aY, _ := strconv.Atoi(aMatches[2])

		bMatches := bRegex.FindStringSubmatch(machineConfig)
		bX, _ := strconv.Atoi(bMatches[1])
		bY, _ := strconv.Atoi(bMatches[2])

		prizeMatches := prizeRegex.FindStringSubmatch(machineConfig)
		prizeX, _ := strconv.Atoi(prizeMatches[1])
		prizeY, _ := strconv.Atoi(prizeMatches[2])

		machines = append(machines, Machine{aX, aY, bX, bY, prizeX, prizeY})
	}

	return machines
}
