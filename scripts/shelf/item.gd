extends Node2D
class_name Item

signal clicked(item : Item)


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		emit_signal("clicked", self)
		#queue_free()
