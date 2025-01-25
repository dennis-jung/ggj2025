extends Area2D
class_name Bubble

const MAX_SCALE = 1.5
const MAX_SCALE_DURATION = 1.0
const MAX_HEIGHT = 400.0

var tween: Tween = null

func _ready() -> void:
	if tween:
		tween.kill()
	scale = Vector2(0.1, 0.1)
	tween = create_tween()
	var max_scale = Vector2(MAX_SCALE, MAX_SCALE)
	tween.tween_property(self, "scale", max_scale, MAX_SCALE_DURATION).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

func release() -> void:
	if tween:
		tween.kill()
	reparent(get_node("/root/Game/Map/MapBubbles"))
	var height = scale.x * MAX_HEIGHT
	tween = create_tween()
	tween.tween_property(self, "position", Vector2(position.x, position.y - height), 1.0).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

func pop() -> void:
	if tween:
		tween.kill()
	queue_free()
