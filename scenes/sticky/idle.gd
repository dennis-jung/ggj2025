extends State
class_name idle_state


func enter() -> void:
	anim.play("idle")
	pass

func exit() -> void:
	pass
	
func update(_delta: float) -> void:
	pass

func update_physics(_delta: float) -> void:
	if parent.velocity.length() > 0:
		state_transition.emit("walking", self)
	parent.move_and_slide()
#func _physics_process(delta: float) -> void:
