extends CanvasLayer

@onready var labelCoins: Label = $LabelCoins
@onready var labelSoap: Label = $LabelSoap

@onready var coin_display: float = 0.0
@onready var soap_display: float = 0.0


var tween: Tween = null
	

func _ready() -> void:
	Main.coin_count_changed.connect(on_coin_count_changed)
	Main.fuel_amount_changed.connect(on_fuel_amount_changed)
	on_coin_count_changed()
	on_fuel_amount_changed()


func _process(_delta: float) -> void:
	labelCoins.text = "Coins:" + str(int(coin_display))
	labelSoap.text = "Soap:" + str(int(soap_display))


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


func on_coin_count_changed() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	print("Coins displayed: ", str(coin_display))
	print("Coins Main displayed: ", str(Main.coins))
	tween.tween_property(self, "coin_display", Main.coins, 0.5)


func on_fuel_amount_changed() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "soap_display", Main.current_fuel, 1.0)
