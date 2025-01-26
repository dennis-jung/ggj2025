extends Node2D

const BUBBLE_Y_POS_MIN = 1000
const BUBBLE_Y_POS_MAX = 300
const MAX_COINS = 100.0

@onready var bubble_sprite: Sprite2D = $BubbleSprite
@onready var label_coins: Label = $UI/LabelCoins
@onready var label_text_025: Label = $UI/LabelText025
@onready var label_text_050: Label = $UI/LabelText050
@onready var label_text_075: Label = $UI/LabelText075
@onready var label_text_100: Label = $UI/LabelText100
@onready var coin_label

var coin_display: int = 0


func _ready() -> void:
	start_bubble()


func _process(delta: float) -> void:
	label_coins.text = "Coins: " + str(coin_display)
	if coin_display >= 25:
		label_text_025.visible = true
	if coin_display >= 50:
		label_text_050.visible = true
	if coin_display >= 75:
		label_text_075.visible = true
	if coin_display >= 100:
		label_text_100.visible = true


func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().quit()
	Main.next_level()


func start_bubble() -> void:
	Main.coins = 100
	var coins = clamp(Main.coins, 0, 100)
	var target_pos_y = BUBBLE_Y_POS_MIN - (BUBBLE_Y_POS_MIN - BUBBLE_Y_POS_MAX) * (Main.coins / MAX_COINS)
	var target_pos = Vector2(bubble_sprite.position.x, target_pos_y)
	var duration = 5.0 * (Main.coins / MAX_COINS)
	var tween = create_tween()
	tween.tween_property(bubble_sprite, "position", target_pos, duration)
	tween.parallel().tween_property(self, "coin_display", Main.coins, duration) 
