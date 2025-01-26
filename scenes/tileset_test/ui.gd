extends CanvasLayer

@onready var labelCoins: Label = $VBoxContainer/LabelCoins
@onready var labelSoap: Label = $VBoxContainer/LabelSoap

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


func on_coin_count_changed() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "coin_display", Main.coins, 0.3)
	tween.parallel().tween_property(labelCoins, "scale", Vector2(1.1,1.1), 0.5)
	tween.tween_property(labelCoins, "scale", Vector2(1.0,1.0), 0.2)


func on_fuel_amount_changed() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "soap_display", Main.current_fuel, 1.0)
