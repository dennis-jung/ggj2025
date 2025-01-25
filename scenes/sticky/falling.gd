extends State
class_name falling_state

func enter() -> void:
	anim.play("falling")
	pass

func exit() -> void:
	pass
	
func update(_delta: float) -> void:
	pass

func update_physics(_delta: float) -> void:
	parent.move_and_slide()
	if parent.velocity.y == 0:
		state_transition.emit("idle", self)

#func _physics_process(delta: float) -> void:
