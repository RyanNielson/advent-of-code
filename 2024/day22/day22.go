package day22

import (
	"aoc2024/utils"
	"strconv"
)

type Sequence struct {
	a int
	b int
	c int
	d int
}

func Part1(inputPath string) int {
	initialSecretNumbers := parse(inputPath)

	secretNumbers := []int{}
	for _, secretNumber := range initialSecretNumbers {
		for j := 0; j < 2000; j++ {
			secretNumber = calculateSecretNumber(secretNumber)
		}
		secretNumbers = append(secretNumbers, secretNumber)
	}

	sum := 0
	for _, secretNumber := range secretNumbers {
		sum += secretNumber
	}

	return sum
}

func Part2(inputPath string) int {
	initialSecretNumbers := parse(inputPath)

	sequencesToPrices := make(map[Sequence][]int)
	for _, secretNumber := range initialSecretNumbers {
		sequencesToHighestPrice := make(map[Sequence]int)
		previousPrice := secretNumber % 10
		currentSequence := Sequence{}

		for j := 0; j < 2000; j++ {
			secretNumber = calculateSecretNumber(secretNumber)
			price := secretNumber % 10

			difference := price - previousPrice
			previousPrice = price

			currentSequence = Sequence{currentSequence.b, currentSequence.c, currentSequence.d, difference}

			_, exists := sequencesToHighestPrice[currentSequence]
			if j >= 3 && !exists {
				sequencesToHighestPrice[currentSequence] = price
			}
		}

		for sequence, price := range sequencesToHighestPrice {
			sequencesToPrices[sequence] = append(sequencesToPrices[sequence], price)
		}
	}

	highest := 0
	for _, prices := range sequencesToPrices {
		sum := 0

		for _, price := range prices {
			sum += price
		}

		if sum > highest {
			highest = sum
		}
	}

	return highest
}

func calculateSecretNumber(secretNumber int) int {
	secretNumber = prune(mix(secretNumber, secretNumber*64))
	secretNumber = prune(mix(secretNumber, secretNumber/32))
	secretNumber = prune(mix(secretNumber, secretNumber*2048))

	return secretNumber
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
