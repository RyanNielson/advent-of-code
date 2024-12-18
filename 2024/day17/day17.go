package day17

import (
	"aoc2024/utils"
	"fmt"
	"strconv"
	"strings"
)

const (
	A = 0
	B = 1
	C = 2
)

func Part1(inputPath string) string {
	registers, instructions, instructionPointer := parse(inputPath)
	outputIntegers := make([]int, 0)
	for {
		if instructionPointer >= len(instructions) {
			break
		}

		opcode := instructions[instructionPointer]
		operand := instructions[instructionPointer+1]

		if opcode == 0 { // adv
			numerator := registers[A]
			denominator := utils.PowInt(2, comboOperand(operand, registers))
			registers[A] = numerator / denominator

		} else if opcode == 1 { // bxl
			registers[B] = registers[B] ^ operand
		} else if opcode == 2 { // bst
			registers[B] = comboOperand(operand, registers) % 8
		} else if opcode == 3 { // jnz
			if registers[A] == 0 {
				// Do nothing
			} else {
				instructionPointer = operand
				continue // So we skip increase by 2
			}
		} else if opcode == 4 { // bxc
			registers[B] = registers[B] ^ registers[C]
		} else if opcode == 5 { // out
			outputIntegers = append(outputIntegers, comboOperand(operand, registers)%8)
		} else if opcode == 6 { // bdv
			numerator := registers[A]
			denominator := utils.PowInt(2, comboOperand(operand, registers))
			registers[B] = numerator / denominator
		} else if opcode == 7 { // cdv
			numerator := registers[A]
			denominator := utils.PowInt(2, comboOperand(operand, registers))
			registers[C] = numerator / denominator
		}

		instructionPointer += 2
	}

	outputStrings := make([]string, 0)
	for _, value := range outputIntegers {
		outputStrings = append(outputStrings, strconv.Itoa(value))
	}

	return strings.Join(outputStrings, ",")
}

func Part2(inputPath string) int {
	return 0
}

func comboOperand(operand int, registers []int) int {
	if operand == 0 || operand == 1 || operand == 2 || operand == 3 {
		return operand
	} else if operand == 4 {
		return registers[A]
	} else if operand == 5 {
		return registers[B]
	} else if operand == 6 {
		return registers[C]
	}

	return 0
}

func parse(inputPath string) (registers []int, instructions []int, instructionPointer int) {
	input := utils.FileText(inputPath)

	inputSections := strings.Split(input, "\n\n")

	for _, registerLine := range strings.Split(inputSections[0], "\n") {
		var registerName string
		var registerValue int
		fmt.Sscanf(registerLine, "Register %s %d", &registerName, &registerValue)
		registers = append(registers, registerValue)
	}

	programSections := strings.Split(inputSections[1], " ")
	for _, instruction := range strings.Split(programSections[1], ",") {
		instructionInt, _ := strconv.Atoi(instruction)
		instructions = append(instructions, instructionInt)
	}

	return registers, instructions, 0
}
