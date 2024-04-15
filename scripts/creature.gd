extends Area2D
class_name Creature

signal clicked(item : Item, status : bool)


@export var move_time := 5
@export var move_speed_factor := 25
@export var move_delay := 10

@onready var _shape := $CollisionShape2D

var _last_move_tick = 0.0
var _move_direction = Vector2(0,0)
var _move_speed_px = 100
var _clicked := false

var is_available_for_summon = false

func _ready():
	#Set a random begin time to move
	_last_move_tick = Time.get_ticks_msec() - randi_range(0, move_delay) * 1000
	
func _process(delta):
	if $Glow != null:
		if is_available_for_summon :
			$Glow.show()
		else:
			$Glow.hide()
	if _clicked:
		global_position = get_viewport().get_mouse_position()
	else:
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

func get_height() -> float:
	return _shape.shape.size.y

func get_width() -> float:
	return _shape.shape.size.x

func _stop_moving() -> void:
	_move_direction = Vector2(0,0)

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		emit_signal("clicked", self, true)
		_clicked = true
		get_tree().get_root().set_input_as_handled()
	if event is InputEventMouseButton and not event.pressed:
		emit_signal("clicked", self, false)
		_clicked = false
