extends Node

signal light_off()

#true if the candle is on (to change top texture and life decrease ?)
var lighted := true

#Maximum lifetime of the candle
@export var total_lifetime = 20.

#Max stack on the candle, excluding top and bottom sprites
@export var max_stacks = 5

#total life in seconds remaining before burning out completely
var remaining_lifetime := 20.

#Factor to increase or decrease speed at which candle burns down
var speed_factor := 1

var _stacks := []

@onready var vBox := $VBoxContainer

func _ready():
	for i in range(0, max_stacks):
		var sprite = Sprite2D.new()
		sprite.texture = preload("res://assets/graphics/candles/stack_1.png")
		add_child(sprite)
		sprite.hide()
		_stacks.append(sprite)	
		
func _process(delta):
	if lighted:
		remaining_lifetime -= delta	* speed_factor
	if remaining_lifetime <= 0:
		remaining_lifetime = 0
		emit_signal("light_off") 
	draw_stacks()
	
func draw_stacks() -> void:
	var nStacksToDisplay = max_stacks * (remaining_lifetime / total_lifetime)
	var ybottom = - 0.5 * $BottomCandle.texture.get_height()
	for i in range(0, max_stacks):
		if i <= nStacksToDisplay:
			_stacks[i].position.x = $BottomCandle.position.x 
			ybottom -= 0.5 * _stacks[i].texture.get_height()
			_stacks[i].position.y = ybottom 
			_stacks[i].show()
		else:
			_stacks[i].hide()
	$TopCandle.position.y = ybottom - 0.5 * $TopCandle.texture.get_height()
	

