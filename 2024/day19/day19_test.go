package day19

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 6, Part1("input_example_1"))
	assert.Equal(t, 240, Part1("input"))
}

func TestPart2(t *testing.T) {
	assert.Equal(t, 16, Part2("input_example_1"))
	assert.Equal(t, 848076019766013, Part2("input"))
}
