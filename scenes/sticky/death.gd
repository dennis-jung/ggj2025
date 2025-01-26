extends State
class_name death_state

func enter() -> void:
	print_debug("Death entered")
	anim.play("death")
	print_debug("Anim play")
	await anim.animation_finished
	print_debug("Anim awaited")
	parent.respawn()
	state_transition.emit("idle", self)
	
func exit() -> void:
	print_debug("Death exited")
	anim.play("RESET")
	anim.advance(0)
	Main.respawned()
	
func update_physics(_delta: float):
	parent.move_and_slide()
	if not parent.is_on_floor():
		parent.velocity += parent.get_gravity() * _delta
