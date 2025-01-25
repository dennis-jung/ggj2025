extends Area2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var _inital_y_pos: float = sprite.position.y

@export var max_displacment: float = 15.0 

var tween: Tween = null

func _ready() -> void:
	if tween:
		tween.kill()
	tween = create_tween().set_loops() # loop the tween 2 times
	tween.tween_interval(randf_range(0.0, 0.5))
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(sprite, "position", Vector2(0,max_displacment), 0.4).as_relative()
	tween.tween_property(sprite, "position", Vector2(0,-max_displacment), 0.4).as_relative()
	#tween.tween_property(sprite, "position:y", _inital_y_pos, 1.0)
	#tween.tween_interval(0.1) # wait for 1 second before repeating

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
		
