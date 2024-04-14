extends Button

signal transform;

func _button_pressed():
	transform.emit();
