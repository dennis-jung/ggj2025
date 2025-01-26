extends Node2D


@onready var upstairs_spawn_point: Marker2D = $UpstairsSpawnPoint
@onready var ui: Ui = $UI


func _on_portal_downstairs_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var sticky: Sticky = body
		sticky.port(upstairs_spawn_point.position)
