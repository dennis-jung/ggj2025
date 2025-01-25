extends Area2D

@export var soap_fuel: float = 15.0

func _on_body_entered(body):
	if body.is_in_group("Player"):
		print("Player picked me up!")
		# add fuel in main
		Main.on_fuel_modified(soap_fuel)
		# destroy myself
		queue_free()
