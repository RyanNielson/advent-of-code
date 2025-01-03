package day07

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 3749, Part1("input_example_1"))
	assert.Equal(t, 20665830408335, Part1("input"))
}

func TestPart2(t *testing.T) {
	assert.Equal(t, 11387, Part2("input_example_1"))
	assert.Equal(t, 354060705047464, Part2("input"))
}
