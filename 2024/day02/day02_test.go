package day02

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 2, Part1("input_example_1"))
	assert.Equal(t, 585, Part1("input"))
}

func TestPart2(t *testing.T) {
	assert.Equal(t, 4, Part2("input_example_1"))
	assert.Equal(t, 626, Part2("input"))
}
