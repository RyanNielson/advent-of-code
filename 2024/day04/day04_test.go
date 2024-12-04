package day04

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 18, Part1("input_example_1"))
	assert.Equal(t, 2530, Part1("input"))
}

func TestPart2(t *testing.T) {
	assert.Equal(t, 9, Part2("input_example_1"))
	assert.Equal(t, 1921, Part2("input"))
}
