extends CanvasLayer

@onready var labelCoins: Label = $LabelCoins

func _ready() -> void:
	Main.coin_count_changed.connect(on_coin_count_changed)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func on_coin_count_changed() -> void:
	labelCoins.text = "Coins:" + str(Main.coins)
