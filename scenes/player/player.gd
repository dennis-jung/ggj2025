extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var bubble_spawn_node = $BubbleSpawner
@onready var map_bubbles_node = %MapBubbles

var bubble_scene = preload("res://scenes/bubble/bubble.tscn")
var current_bubble: Bubble = null

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("create_bubble"):
		create_bubble()
	if Input.is_action_just_released("create_bubble"):
		release_bubble()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		sprite.flip_h = direction < 0
		sprite.play("walk_right")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if velocity.x == 0:
		sprite.play("idle")

	move_and_slide()

func create_bubble() -> void:
	if current_bubble:
		return
	var bubble = bubble_scene.instantiate()
	current_bubble = bubble
	bubble_spawn_node.add_child(bubble)

func release_bubble() -> void:
	if current_bubble == null:
		return
	current_bubble.release()
	current_bubble = null
