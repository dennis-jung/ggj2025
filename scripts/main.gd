extends Node

signal coin_count_changed
signal fuel_amount_changed

@export var max_fuel: float = 100.0
@export var starting_fuel: float = 100.0

@onready var coins: int = 0
@onready var current_fuel: float = starting_fuel

func load_level(level_path: String, target_node: Node2D) -> void:
	for child in target_node.get_children():
		child.queue_free()
	var res = ResourceLoader.load_threaded_get(level_path)
	var level = res.instantiate()
	target_node.add_child(level)

func is_fuel_full() -> bool:
	return current_fuel >= max_fuel
	

func on_fuel_modified(difference: float) -> void:
	current_fuel += difference
	if current_fuel < 0:
		current_fuel = 0.0
	elif current_fuel > max_fuel:
		current_fuel = max_fuel
	fuel_amount_changed.emit()
	
func on_coin_pickup(coin_value: int) -> void:
	coins += coin_value
	coin_count_changed.emit()
