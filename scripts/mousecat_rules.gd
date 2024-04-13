extends Node

var t
var shake
var upgradeAvailable

func _ready():
	while (true):
		upgradeAvailable = !upgradeAvailable
		t = 0
		await get_tree().create_timer(1.0).timeout
	
func _process(_delta):
	if upgradeAvailable:
		t = t + 1
		$Alarm.show()
		$Alarm.color = Color(255, 0, 0, sin(0.1*t))
		$upgrade.show()
	else:
		$Alarm.hide()
		$upgrade.show()

func setValues(mice, cats):
	$nb_mouse.text = mice
	$nb_cat.text = cats
