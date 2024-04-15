extends Creature
class_name Demon

func _process(delta: float) -> void:
	global_position.x -= delta * 300
	if (global_position.x < -200):
		queue_free()
