extends Area2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var _inital_y_pos: float = sprite.position.y

@export var max_displacment: float = 15.0 

var tween: Tween = null

func _ready() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween = create_tween().set_loops(200) # loop the tween 2 times
	tween.tween_interval(randf_range(0.0, 0.5))
	tween.tween_property(sprite, "position:y", max_displacment, 0.2)
	tween.tween_property(sprite, "position:y", _inital_y_pos, 1.0)
	tween.tween_interval(1) # wait for 1 second before repeating

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func release() -> void:
	if tween:
		tween.kill()
	queue_free()

func _on_body_entered(body):
	if body.is_in_group("Player"):
		# add point in main
		Main.on_coin_pickup()
		# destroy myself
		release()
		
