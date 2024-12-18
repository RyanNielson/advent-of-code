package day17

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, "4,6,3,5,6,3,5,2,1,0", Part1("input_example_1"))
	assert.Equal(t, "7,3,5,7,5,7,4,3,0", Part1("input"))
}

// func TestPart2(t *testing.T) {
// 	// assert.Equal(t, 102718967795500, Part2("input", 101, 103))
// }
