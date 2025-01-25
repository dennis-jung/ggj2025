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

func _on_area_2d_body_entered(body: Node2D) -> void:
	pop()
	
func release() -> void:
	if tween:
		tween.kill()
	reparent(get_node("/root/Game/Map/MapBubbles"))
	var height = scale.x * MAX_HEIGHT
	tween = create_tween()
	tween.tween_property(self, "position", Vector2(position.x, position.y - height), 1.0).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

func pop(now: bool = false) -> void:
	if now:
		queue_free()
		return
	if tween:
		tween.kill()
	tween = create_tween()
	var target_scale_x = scale.x * 0.8
	var target_scale_y = scale.y
	tween.tween_property(self, "scale", Vector2(target_scale_x, target_scale_y), 0.5).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN)
	tween.tween_callback(self.queue_free)
