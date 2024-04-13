extends Node

@onready var _upgrade_texture_button := $upgrade
@onready var _nb_spider_label := $nb_spider
@onready var _nb_mouse_label := $nb_mouse
@onready var _alarm_color_rect := $Alarm

var t := 0
#var shake
var upgradeAvailable := false

signal summon_spidermouse;

func _ready():
	_upgrade_texture_button.transform.connect(spawnTransformation)
	upgradeAvailable = true
		
func setValues(spiders, mice):
	_nb_spider_label.text = str(spiders)
	_nb_mouse_label.text = str(mice)
	
func _process(_delta):
	if upgradeAvailable:
		t = t + 1
		_alarm_color_rect.show()
		_alarm_color_rect.color = Color(255, 0, 0, sin(0.1*t))
		_upgrade_texture_button.show()
	else:
		_alarm_color_rect.hide()
		_upgrade_texture_button.show()

func spawnTransformation():
	print("summon a spidermouse")
	upgradeAvailable = false;
	summon_spidermouse.emit();
