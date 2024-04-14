extends Node

@onready var _upgrade_texture_button := $upgrade
@onready var _nb_spider_label := $nb_spider
@onready var _nb_mouse_label := $nb_mouse
@onready var _alarm_color_rect := $Alarm

var upgradeAvailable := false

signal summon_creature;

func _ready():
	_upgrade_texture_button.transform.connect(spawnTransformation)
		
func setValues(spiders, mice):
	_nb_spider_label.text = str(spiders)
	_nb_mouse_label.text = str(mice)
	
func _process(_delta):
	if upgradeAvailable:
		_alarm_color_rect.show()
		_alarm_color_rect.color = Color(255, 0, 0, sin(PI*Global.time))
		_upgrade_texture_button.show()
	else:
		_alarm_color_rect.hide()
		_upgrade_texture_button.hide()

func spawnTransformation():
	print("summon a spidermouse")
	upgradeAvailable = false;
	summon_creature.emit(Global.summons.MouseSpider, 1);

func update_upgradeAvailable(creature, isAvailable):
	if (creature == Global.summons.MouseSpider):
		upgradeAvailable = isAvailable
