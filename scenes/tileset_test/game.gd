extends Node2D

@onready var map_bubbles_node = %MapBubbles

#func _physics_process(delta: float) -> void:
	#for bubble: Bubble in map_bubbles_node.get_children():
		#if bubble.energy <= 0:
			#continue
		#bubble.translate(Vector2(0.0, -1))
		#bubble.energy -= 1
		#print_debug("bubble energy left: ", bubble.energy)
