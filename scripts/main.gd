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

var deaths: int = 0
var currently_dead = false

func _ready() -> void:
	change_level(0)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
		
		
func next_level() -> void:
	current_level += 1
	if current_level >= levels.size():
		current_level = 0
		# TODO: Win!!!
		return
	var ui_node = get_node("/root/Level/UI")
	if ui_node and ui_node.has_method("fade_out"):
		ui_node.fade_out_finished.connect(on_fade_out_finished)
		ui_node.fade_out()
	else:
		change_level(current_level)	


func on_fade_out_finished() -> void:
	change_level(current_level)


func change_level(index) -> void:
	get_tree().change_scene_to_packed(levels[index])


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

func on_death() -> void:
	deaths += 1
	currently_dead = true

func respawned() -> void:
	currently_dead = false
