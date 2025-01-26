extends CanvasLayer
class_name Ui

signal fade_out_finished

@onready var labelCoins: Label = $VBoxContainer/LabelCoins
@onready var labelSoap: Label = $VBoxContainer/LabelSoap
@onready var fader: ColorRect = $Fader

@onready var coin_display: float = 0.0
@onready var soap_display: float = 0.0


var tween: Tween = null
	

func _ready() -> void:
	Main.coin_count_changed.connect(on_coin_count_changed)
	Main.fuel_amount_changed.connect(on_fuel_amount_changed)
	on_coin_count_changed()
	on_fuel_amount_changed()
	fade_in()


func _process(_delta: float) -> void:
	labelCoins.text = "Coins:" + str(int(coin_display))
	labelSoap.text = "Soap:" + str(int(soap_display))


func fade_in() -> void:
	var tween = create_tween()
	tween.tween_property(fader, "color:a", 0.0, 2.0)


func fade_out() -> void:
	var tween = create_tween()
	tween.tween_property(fader, "color:a", 1.0, 2.0)
	tween.finished.connect(on_fade_out_finished)


func on_fade_out_finished() -> void:
	fade_out_finished.emit()


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
