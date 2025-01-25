extends StaticBody2D
class_name Bubble

const MAX_SCALE = 2
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

func pop(now: bool = false) -> void:
	if tween:
		tween.kill()
	if now:
		queue_free()
		return
	tween = create_tween()
	var target_scale = scale.x * 0.8
	tween.tween_property(self, "scale", target_scale, 0.5).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN)
	tween.tween_callback(self.queue_free)
