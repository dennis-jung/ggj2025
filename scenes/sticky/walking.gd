extends State
class_name walking_state

@export var speed = 2.2
#@onready var timer: Timer = get_node("Timer")


func enter():
	anim.play("walk")


func update_physics(_delta: float):
	parent.move_and_slide()
	update_state()


func update_state() -> void:
	if parent.velocity.length() == 0:
		state_transition.emit("idle", self)
