extends VBoxContainer


@onready var _music := $MenuMusic
@onready var _credit := $CreditContainer
@onready var _button_sound := $ButtonsContainer/ButtonSound
@onready var _credit_sound := preload("res://assets/audio/credit.mp3")


func _ready() -> void:
	_music.play()


func _on_start_pressed() -> void:
	_button_sound.play()
	await get_tree().create_timer(1.0).timeout
	#get_tree().change_scene_to_file("res://scenes/game_main.tscn")
	$Score.start();


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_credit_pressed() -> void:
	_button_sound.play()
	_credit.visible = true
	_music.stream = _credit_sound
	_music.play()
