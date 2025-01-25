extends Node2D
class_name Bubble

const MAX_SCALE = 1
const MAX_SCALE_DURATION = 2.0
const MAX_HEIGHT = 1000.0

@onready var bubble_area: Area2D = $Area2D
@onready var bubble_body: StaticBody2D = $StaticBody2D

var tween: Tween = null
var is_popping: bool = false

func _ready() -> void:
	if tween:
		tween.kill()
	scale = Vector2(0.1, 0.1)
	tween = create_tween()
	var max_scale = Vector2(MAX_SCALE, MAX_SCALE)
	tween.tween_property(self, "scale", max_scale, MAX_SCALE_DURATION).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == bubble_body:
		return
	pop()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Bubble :
		area.get_parent().pop()
		pop()
	
func release() -> void:
	if is_popping:
		return
	if tween:
		tween.kill()
	reparent(get_node("/root/Game/Map/MapBubbles"))
	var height = scale.x * MAX_HEIGHT
	tween = create_tween()
	tween.tween_property(self, "position", Vector2(position.x, position.y - height), 3.0).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

func pop(now: bool = false) -> void:
	if is_popping:
		return
	if now:
		queue_free()
		return
	if tween:
		tween.kill()
	tween = create_tween()
	var target_scale_x = scale.x * 0.8
	var target_scale_y = scale.y
	tween.tween_property(self, "scale", Vector2(target_scale_x, target_scale_y), 1.0).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_callback(self.queue_free)
