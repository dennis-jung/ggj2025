extends Node

signal coin_count_changed
signal fuel_amount_changed

const levels = [
	preload("res://scenes/tileset_test/game.tscn"),
	preload("res://scenes/levels/level_001/level_001.tscn")
]

@export var max_fuel: float = 100.0
@export var starting_fuel: float = 100.0

@onready var coins: int = 0
@onready var current_fuel: float = starting_fuel

var current_level = 0


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
		
		
func next_level() -> void:
	current_level += 1
	if current_level >= levels.size():
		current_level = 0
		# TODO: Win!!!
		return
	get_tree().change_scene_to_packed(levels[current_level])
	

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
