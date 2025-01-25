extends Area2D

@export var soap_fuel: float = 15.0

func _on_body_entered(body):
	if body.is_in_group("Player"):
		if can_pick_up_fuel():
			# add fuel in main
			Main.on_fuel_modified(soap_fuel)
			# destroy myself
			queue_free()

func can_pick_up_fuel() -> bool:
	return not Main.is_fuel_full()
