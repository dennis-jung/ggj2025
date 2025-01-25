extends Node2D

@onready var sticky: Sticky = $Sticky
@onready var upstairs_spawn_point: Marker2D = $Map/UpstairsSpawnPoint

func _on_portal_body_entered(body: Node2D) -> void:
	if body == sticky:
		sticky.position = upstairs_spawn_point.position
