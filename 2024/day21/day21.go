package day21

import (
	"aoc2024/utils"
	"strconv"
)

func Part1(inputPath string) int {
	initialSecretNumbers := parse(inputPath)

	secretNumbers := []int{}
	for _, secretNumber := range initialSecretNumbers {
		for j := 0; j < 2000; j++ {
			secretNumber = prune(mix(secretNumber, secretNumber*64))
			secretNumber = prune(mix(secretNumber, secretNumber/32))
			secretNumber = prune(mix(secretNumber, secretNumber*2048))
		}
		secretNumbers = append(secretNumbers, secretNumber)
	}

	sum := 0
	for _, secretNumber := range secretNumbers {
		sum += secretNumber
	}
	// fmt.Println(secretNumbers)
	return sum
}

func mix(secretNumber int, value int) int {
	return secretNumber ^ value
}

func prune(secretNumber int) int {
	return secretNumber % 16777216
}

func parse(inputPath string) []int {
	initialSecretStrings := utils.FileLines(inputPath)
	initialSecretNumbers := []int{}
	for _, initialSecretString := range initialSecretStrings {
		initialSecretNumber, _ := strconv.Atoi(initialSecretString)
		initialSecretNumbers = append(initialSecretNumbers, initialSecretNumber)
	}

	return initialSecretNumbers
}
