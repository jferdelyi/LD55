extends Creature
class_name Demon

func _process(delta: float) -> void:
	global_position.x -= delta * 300
	global_position.y = 720 / 2.0
	if (global_position.x < -200):
		get_parent().remove_child(self)
		queue_free()
