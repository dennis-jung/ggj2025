extends State
class_name death_state

func enter() -> void:
	print("Death entered")
	anim.play("death")
	await anim.animation_finished
	parent.respawn()
	state_transition.emit("idle", self)
	
func exit() -> void:
	print("Death exited")
	Main.respawned()
	
func update_phsics(_delta: float):
	parent.move_and_slide()
