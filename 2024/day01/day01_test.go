package day01

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	result := Part1()

	// if result != 0 {
	// 	t.Errorf("expected '%d' but got '%d'", 0, result)
	// }

	assert.Equal(t, 0, result)
}

func TestPart2(t *testing.T) {
	result := Part1()

	if result != 0 {
		t.Errorf("expected '%d' but got '%d'", 0, result)
	}
}
