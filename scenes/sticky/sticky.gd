extends CharacterBody2D
class_name Sticky

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var bubble_spawn_node = $BubbleSpawner
@onready var map_bubbles_node = %MapBubbles

var bubble_scene = preload("res://scenes/bubble/bubble.tscn")
var current_bubble: Bubble = null
var just_ported: bool = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("create_bubble"):
		create_bubble()
	if Input.is_action_just_released("create_bubble"):
		release_bubble()

func port(destination: Vector2) -> void:
	position = destination
	just_ported = true

func create_bubble() -> void:
	if Main.current_fuel <= 0:
		return
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

func respawn() -> void:
	pass
