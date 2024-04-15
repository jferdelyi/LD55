extends VBoxContainer


@onready var _music := $MenuMusic
@onready var _credit := $CreditContainer
@onready var _button_audio_player := $ButtonsContainer/ButtonSound
@onready var _credit_sound := preload("res://assets/audio/Credit.wav")
@onready var _credit_button_sound := preload("res://assets/audio/FX/Bouton_credit.wav")
@onready var _start_button_sound := preload("res://assets/audio/FX/Bouton_start.wav")


func _ready() -> void:
	Global.with_tutorial = true
	_music.play()


func _on_start_pressed() -> void:
	_button_audio_player.stream = _start_button_sound
	_button_audio_player.play()
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://scenes/game_main.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_credit_pressed() -> void:
	_credit.visible = true
	_music.stream = _credit_sound
	_button_audio_player.stream = _credit_button_sound
	_button_audio_player.play()
	await get_tree().create_timer(0.5).timeout
	_music.play()


func _on_check_box_toggled(toggled_on: bool) -> void:
	Global.with_tutorial = toggled_on
