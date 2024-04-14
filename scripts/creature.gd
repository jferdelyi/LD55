extends Node2D
class_name Creature

@export var move_time := 3
@export var move_speed_factor := 10
@export var move_delay := 20

var _last_move_tick = 0.0
var _move_direction = Vector2(0,0)
var _move_speed_px = 100

func _ready():
	#Set a random begin time to move
	_last_move_tick = Time.get_ticks_msec() - randi_range(0, move_delay) * 1000
	
func _process(delta):
	move_around(delta)
	
func move_around(delta) -> void:
	var is_moving = Time.get_ticks_msec() - _last_move_tick < move_time * 1000
	var can_move = Time.get_ticks_msec() - _last_move_tick > move_delay * 1000
	
	if is_moving:
		_continue_moving(delta)
	elif can_move:
		_initiate_move()
	else:
		_stop_moving()
		
func _continue_moving(delta) -> void:
	position += _move_direction * move_speed_factor * delta
	
func _initiate_move() -> void:
	_last_move_tick = Time.get_ticks_msec()
	var vx = randi_range(- _move_speed_px, _move_speed_px)
	var vy = randi_range(-_move_speed_px, _move_speed_px)
	if Vector2(vx, vy) != Vector2(0,0):
		_move_direction = Vector2(vx, vy).normalized()
	

func _stop_moving() -> void:
	_move_direction = Vector2(0,0)
	


