extends Node2D


@onready var upstairs_spawn_point: Marker2D = $UpstairsSpawnPoint


func _on_portal_downstairs_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var sticky: Sticky = body
		sticky.port(upstairs_spawn_point.position)


func _on_exit_body_entered(body: Node2D) -> void:
	Main.next_level()
