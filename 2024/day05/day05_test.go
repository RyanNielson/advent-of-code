package day05

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 143, Part1("input_example_1"))
	assert.Equal(t, 7365, Part1("input"))
}

func TestPart2(t *testing.T) {
	assert.Equal(t, 123, Part2("input_example_1"))
	assert.Equal(t, 5770, Part2("input"))
}
