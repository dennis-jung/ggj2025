extends Node2D

const BUBBLE_Y_POS_MIN = 1000
const BUBBLE_Y_POS_MAX = 300
const MAX_COINS = 200.0
const COINS_PER_DEATH = 50

@onready var bubble_sprite: Sprite2D = $BubbleSprite
@onready var label_coins: Label = $UI/LabelCoins
@onready var label_deaths: Label = $UI/LabelDeaths
@onready var label_text_0: Label = $UI/LabelText0
@onready var label_text_025: Label = $UI/LabelText025
@onready var label_text_050: Label = $UI/LabelText050
@onready var label_text_075: Label = $UI/LabelText075
@onready var label_text_100: Label = $UI/LabelText100
@onready var coin_label

var coin_display: int = 0
var deaths_display: int = 0

func _ready() -> void:
	start_bubble()


func _process(delta: float) -> void:
	label_coins.text = "Coins: " + str(coin_display)
	label_deaths.text = "Deaths: " + str(deaths_display)
	if coin_display == 0:
		label_text_0.text = "REALLY? ZERO?"
	if coin_display > 0:
		label_text_0.text = "PATHETIC!"
	if coin_display < 0:
		label_text_0.text = "OMG, SHAMEFUL!!!"
	label_text_025.visible = coin_display >= MAX_COINS * 0.25
	label_text_050.visible = coin_display >= MAX_COINS * 0.5
	label_text_075.visible = coin_display >= MAX_COINS * 0.75
	label_text_100.visible = coin_display >= MAX_COINS


func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().quit()
	Main.next_level()


func start_bubble() -> void:
	#Main.coins = 400
	#Main.deaths = 10
	var coins = clamp(Main.coins, 0, MAX_COINS)
	var target_pos_y = BUBBLE_Y_POS_MIN - (BUBBLE_Y_POS_MIN - BUBBLE_Y_POS_MAX) * (coins / MAX_COINS)
	var target_pos = Vector2(bubble_sprite.position.x, target_pos_y)
	var duration = 5.0 * (Main.coins / MAX_COINS)
	var tween = create_tween()
	tween.tween_property(bubble_sprite, "position", target_pos, duration)
	tween.parallel().tween_property(self, "coin_display", Main.coins, duration)
	await tween.finished
	print_debug("tween.finished")
	tween.kill()
	await get_tree().create_timer(1).timeout
	label_deaths.visible = true
	var coins_after_deaths = coins - Main.deaths * COINS_PER_DEATH
	print_debug("coins before death: " + str(coins))
	print_debug("coins after deaths: " + str(coins_after_deaths))
	target_pos_y = BUBBLE_Y_POS_MIN - (BUBBLE_Y_POS_MIN - BUBBLE_Y_POS_MAX) * (coins_after_deaths / MAX_COINS)
	print_debug("target_pos after deaths: " + str(target_pos_y))
	target_pos = Vector2(bubble_sprite.position.x, target_pos_y)
	duration = 3.0 * ((coins - coins_after_deaths) / MAX_COINS)
	print_debug("duration after deaths: " + str(duration))
	tween = create_tween()
	tween.tween_property(bubble_sprite, "position", target_pos, duration)
	#tween.parallel().tween_property(self, "coin_display", coins_after_deaths, duration)
	tween.parallel().tween_property(self, "deaths_display", Main.deaths, duration)
