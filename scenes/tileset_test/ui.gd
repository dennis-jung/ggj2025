extends CanvasLayer

@onready var labelCoins: Label = $LabelCoins
@onready var labelSoap: Label = $LabelSoap

func _ready() -> void:
	Main.coin_count_changed.connect(on_coin_count_changed)
	Main.fuel_amount_changed.connect(on_fuel_amount_changed)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func on_coin_count_changed() -> void:
	labelCoins.text = "Coins:" + str(Main.coins)

func on_fuel_amount_changed() -> void:
	labelSoap.text = "Soap:" + str(Main.current_fuel)
