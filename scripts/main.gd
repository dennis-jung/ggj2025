extends Node

@export var max_fuel: float = 100.0
@export var starting_fuel: float = 100.0

@onready var coins: int = 0
@onready var current_fuel: float = starting_fuel

func on_fuel_modified(difference: float) -> void:
	current_fuel += difference
	
func on_coin_pickup() -> void:
	coins += 1
