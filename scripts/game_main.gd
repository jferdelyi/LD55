extends Node2D

#@onready var _shelf_item_class := preload("res://scenes/creatures/cat_food.tscn")
@onready var _score_label := $ScoreScene
@onready var _shelf := $Shelf
@onready var _pentagram := $Pentagram
@onready var _tomb := $Tomb
@onready var _background := $GameBackground
@onready var _ambiance_player := $AmbianceAudioStreamPlayer
@onready var _candle := $Candle
@onready var _final_score_label := $EndGame/ScorePanel/Label
@onready var _end_game := $EndGame
@onready var _music := $AudioStreamPlayer
@onready var _tutorial := $Tutorial

@onready var _stress_sound := preload("res://assets/audio/Play_50_a_0_bougie.wav")
@onready var _normal_sound := preload("res://assets/audio/Play_100_a_50_bougie.wav")

var w_min = 170
var w_max = 1280
var h_min = 480
var h_max = 720

# Nulaiech
var h_min_tomb = 620
var w_tomb = 395
var h_min_shelf = 590
var w_shelf = 855

var _normal_music := true


func _ready():
	if Global.with_tutorial:
		_tutorial.start()
	Global.with_tutorial = false
	#_pentagram.spawn_summons(Global.summons.Cat, 10)
	#_pentagram.spawn_summons(Global.summons.Spider, 10)
	#_pentagram.spawn_summons(Global.summons.Mouse, 10)
	var summ = Global.summons
	_score_label.start()
	_tomb.setValues(
		Global.get_requirements_for_with(summ.SpiderCat, summ.Spider),
		Global.get_requirements_for_with(summ.SpiderCat, summ.Cat),
		Global.get_requirements_for_with(summ.CatMouse, summ.Mouse),
		Global.get_requirements_for_with(summ.CatMouse, summ.Cat),
		Global.get_requirements_for_with(summ.MouseSpider, summ.Mouse),
		Global.get_requirements_for_with(summ.MouseSpider, summ.Spider),
		Global.get_requirements_for_with(summ.Demon, summ.SpiderCat),
		Global.get_requirements_for_with(summ.Demon, summ.MouseSpider),
	 	Global.get_requirements_for_with(summ.Demon, summ.CatMouse))
	_tomb.show()

func _process(_delta):
	check_creatures_position()
	var _creature_count : int = _pentagram.get_number_of_all_summons()
	if _creature_count == 0:
		_candle.set_speed_factor(0.1)
	else:
		_candle.set_speed_factor(1.0 + _creature_count * 0.05)
	if not _normal_music and _candle.remaining_lifetime >= 50.0:
		_music.stream = _normal_sound
		_music.play()
		_normal_music = true
	elif _normal_music and _candle.remaining_lifetime < 50.0:
		_music.stream = _stress_sound
		_music.play()
		_normal_music = false

func _on_shelf_item_used(item: Variant) -> void:
	if item is CatFood:
		_pentagram.spawn_summons(Global.summons.Cat, 1)
	if item is SpiderFood:
		_pentagram.spawn_summons(Global.summons.Spider, 1)
	if item is MouseFood:
		_pentagram.spawn_summons(Global.summons.Mouse, 1)
	if item is Candle:
		_candle.set_life(Global.CandleLife)


func _on_pop_menu_item_selected(item: Variant) -> void:
	_shelf.add_item(item)


func check_creatures_position():
	const min_scale = 0.33
	for child in _pentagram.get_creatures():
		if child is Demon:
			continue
		if child is Creature:
			var computed_h_max : float = h_max - (child.get_height() / 4.0)
			if child.global_position.x <= w_tomb:
				child.global_position.y = clamp(child.global_position.y, h_min_tomb, computed_h_max)
			elif child.global_position.x >= w_shelf:
				child.global_position.y = clamp(child.global_position.y, h_min_shelf, computed_h_max)
			else:
				child.global_position.y = clamp(child.global_position.y, h_min, computed_h_max)
			child.global_position.x = clamp(child.global_position.x, w_min, w_max)
			child.z_index = _background.z_index + _shelf.z_index + _tomb.z_index + (child.global_position.y + child.get_height() / 2.0)
			var yPos = (child.global_position.y - h_min) / (computed_h_max - h_min) 
			child.scale = Vector2(1,1) * (min_scale + (1. - min_scale) * yPos)


func _on_candle_light_off() -> void:
	get_tree().paused = true
	_end_game.visible = true
	_final_score_label.text = str(_score_label.score)

func _on_audio_stream_player_finished() -> void:
	_music.play()

func _on_pentagram_demon_summoned() -> void:
	_score_label.demon_score()
	_candle.set_life(Global.CandleLife)

func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game_main.tscn")

func _on_ambiance_audio_stream_player_finished() -> void:
	_ambiance_player.play()
