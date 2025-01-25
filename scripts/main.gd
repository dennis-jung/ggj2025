extends Node

signal coin_count_changed
signal fuel_amount_changed

@export var max_fuel: float = 100.0
@export var starting_fuel: float = 100.0

@onready var coins: int = 0
@onready var current_fuel: float = starting_fuel


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
