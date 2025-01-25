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
	# Add the gravity.
	if not parent.is_on_floor():
		parent.velocity += parent.get_gravity() * _delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and parent.is_on_floor():
		parent.velocity.y = parent.JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		parent.velocity.x = direction * parent.SPEED
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, parent.SPEED)

	if parent.velocity.length() > 0:
		state_transition.emit("walking", self)
	parent.move_and_slide()
