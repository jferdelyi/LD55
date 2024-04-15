extends Node2D


@onready var _steps_canvas := $CanvasGroup/Steps

var _steps := []
var _current_step := 0


func _ready() -> void:
	_steps = _steps_canvas.get_children()
	_steps[_current_step].visible = true


func start() -> void:
	get_tree().paused = true
	visible = true


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		_steps[_current_step].visible = false
		_current_step = _current_step + 1
		if _current_step == _steps.size():
			get_tree().paused = false
			visible = false
		else:
			_steps[_current_step].visible = true
