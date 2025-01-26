extends State
class_name JumpingState


# Called when the node enters the scene tree for the first time.
func enter() -> void:
	if parent.velocity.x > 0:
		anim.play("jumping_right")
	else:
		anim.play("jumping_left")


func exit() -> void:
	anim.play("RESET")
	anim.advance(0)

	
func update(_delta: float) -> void:
	pass

func update_physics(_delta: float) -> void:
	# Add the gravity.
	if not parent.is_on_floor():
		parent.velocity += parent.get_gravity() * _delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		parent.velocity.x = direction * parent.SPEED
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, parent.SPEED)

	parent.move_and_slide()
	if parent.velocity.y > 0:
		state_transition.emit("falling", self)
	elif parent.velocity.y == 0 or parent.is_on_floor():
		state_transition.emit("idle", self)
