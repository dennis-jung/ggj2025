extends Area2D

@export var soap_fuel: float = 15.0
@export var max_displacment: float = 25.0

var tween: Tween = null

func _ready() -> void:
	if tween:
		tween.kill()
	tween = create_tween().set_loops() # loop the tween 2 times
	tween.tween_interval(randf_range(2.0, 4.0))
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "rotation_degrees", max_displacment, 0.1).as_relative()
	tween.tween_property(self, "rotation_degrees", -max_displacment, 0.1).as_relative()
	#tween.tween_property(sprite, "position:y", _inital_y_pos, 1.0)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		if can_pick_up_fuel():
			# add fuel in main
			Main.on_fuel_modified(soap_fuel)
			# destroy myself
			release()


func can_pick_up_fuel() -> bool:
	return not Main.is_fuel_full()


func release() -> void:
	if tween:
		tween.kill()
	queue_free()
