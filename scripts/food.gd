extends Node2D
class_name Food


signal new_creature()


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		emit_signal("new_creature")
		queue_free()
