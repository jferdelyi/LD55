extends Node2D

signal light_off


#Maximum lifetime of the candle
@export var total_lifetime = 100.0


#true if the candle is on (to change top texture and life decrease ?)
var lighted := true
var _last_index := 10
var _stack_step_value : int
 
#total life in seconds remaining before burning out completely
var remaining_lifetime := 100.0

#Factor to increase or decrease speed at which candle burns down
var _speed_factor := 0

var _candle_stack := []


func _ready():
	_stack_step_value = total_lifetime / 10.0
	for i in range(11):
		_candle_stack.push_back(get_node("Candle" + str(i)))


func _process(delta):
	if lighted:
		remaining_lifetime -= delta * _speed_factor
		var _new_index = get_index_by_lifetime();
		if _new_index != _last_index:
			_last_index = _new_index
			display_candle_index(_new_index)
	if remaining_lifetime <= 0:
		remaining_lifetime = 0
		emit_signal("light_off")


func set_speed_factor(speed_factor: int):
	_speed_factor = speed_factor


func set_life(delta_life: int):
	remaining_lifetime = min(remaining_lifetime + delta_life, total_lifetime)
	lighted = remaining_lifetime > 0
	# Will see...
	#if remaining_lifetime > total_lifetime:
	#	total_lifetime = remaining_lifetime
	#	_stack_step_value = total_lifetime / 10.0


func get_index_by_lifetime() -> int:
	if remaining_lifetime == 0:
		return 0
	return (remaining_lifetime / _stack_step_value) + 1


func display_candle_index(index : int) -> void:
	for candle in _candle_stack:
		candle.visible = false
	_candle_stack[index].visible = true
