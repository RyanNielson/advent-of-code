package day10

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 1, Part1("input_example_1"))
	assert.Equal(t, 36, Part1("input_example_2"))
	assert.Equal(t, 667, Part1("input"))
}

func TestPart2(t *testing.T) {
	assert.Equal(t, 81, Part2("input_example_2"))
	assert.Equal(t, 1344, Part2("input"))
}
