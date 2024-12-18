package day18

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 22, Part1("input_example_1", 6, 12))
	assert.Equal(t, 370, Part1("input", 70, 1024))
}

// func TestPart2(t *testing.T) {
// 	// assert.Equal(t, 117440, Part2("input_example_1"))
// 	// assert.Equal(t, 1, Part2("input"))
// }
