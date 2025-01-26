extends Marker2D

@export var scream: AudioStream

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer




func _on_area_2d_body_entered(body):
	if not scream:
		printerr("No Scream provided!")
	if body.is_in_group("Player"):
		audio_player.stream = scream
		audio_player.play()
		Main.on_death()
