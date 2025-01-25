extends State
class_name walking_state

@export var speed = 2.2
#@onready var timer: Timer = get_node("Timer")


func enter():
	anim.play("walk")


func update_physics(_delta: float):
	# Add the gravity.
	if not parent.is_on_floor():
		parent.velocity += parent.get_gravity() * _delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and parent.is_on_floor():
		parent.velocity.y = parent.JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction and not parent.just_ported:
		parent.velocity.x = direction * parent.SPEED
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, parent.SPEED)
		
	parent.move_and_slide()
	update_state()


func update_state() -> void:
	if parent.velocity.length() == 0:
		state_transition.emit("idle", self)
	elif parent.velocity.y > 0:
		state_transition.emit("falling", self)
