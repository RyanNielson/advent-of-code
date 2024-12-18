package day18

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 22, Part1("input_example_1", 6, 12))
	assert.Equal(t, 370, Part1("input", 70, 1024))
}

func TestPart2(t *testing.T) {
	assert.Equal(t, "6,1", Part2("input_example_1", 6, 12))
	assert.Equal(t, "65,6", Part2("input", 70, 1024))
}
