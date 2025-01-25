extends Node2D

@onready var upstairs_spawn_point: Marker2D = $Map/UpstairsSpawnPoint

func _on_portal_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var sticky: Sticky = body
		sticky.port(upstairs_spawn_point.position)
