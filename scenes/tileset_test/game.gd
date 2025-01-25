extends Node2D

@onready var level_spawner_node = $Level

func _ready() -> void:
	Main.load_level("scenes/levels/level_001.tscn", level_spawner_node)
