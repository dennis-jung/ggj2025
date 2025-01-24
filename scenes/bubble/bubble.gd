extends Area2D
class_name Bubble

const MAX_SIZE = 1.0

var size: float = 0.1
var energy: int = 0

func blow(value: float) -> void:
	if size + value < MAX_SIZE:
		size += value
	energy = size * 400
	scale = Vector2(size, size)

func release() -> void:
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(position.x, position.y - energy), 1.0).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
