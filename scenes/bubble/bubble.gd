extends Area2D
class_name Bubble

const MAX_SIZE = 1.0

var size: float = 0.1
var energy: int = 0

func blow(value: float) -> void:
	if size + value < MAX_SIZE:
		size += value
	energy = size * 100
	scale = Vector2(size, size)
