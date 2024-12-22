package day21

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 37327623, Part1("input_example_1"))
	assert.Equal(t, 12979353889, Part1("input"))
}
