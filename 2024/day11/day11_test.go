package day11

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 55312, Part1("input_example_1"))
	assert.Equal(t, 197357, Part1("input"))
}

func TestPart2(t *testing.T) {
	assert.Equal(t, 234568186890978, Part2("input"))
}
