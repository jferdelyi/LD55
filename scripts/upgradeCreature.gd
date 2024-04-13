extends TextureButton

signal transform;

func _button_pressed():
	transform.emit();
