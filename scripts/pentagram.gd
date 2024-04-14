extends Node


@onready var _cat_class := preload("res://scenes/creatures/cat.tscn")
@onready var _spider_class := preload("res://scenes/creatures/spider.tscn")
@onready var _mouse_class := preload("res://scenes/creatures/mouse.tscn")
@onready var _spidercat_class := preload("res://scenes/creatures/spidercat.tscn")
@onready var _mousespider_class := preload("res://scenes/creatures/mousespider.tscn")
@onready var _catmouse_class := preload("res://scenes/creatures/catmouse.tscn")
@onready var _demon_class := preload("res://scenes/creatures/demon.tscn")

@onready var _background_sprite := $Background
@onready var _pentagram_area := $Area2D/CollisionShape2D

var summons_container = {}

signal chimera_available
signal chimera_updated

func _ready():
	#TODO : doute ici sur le .values() du enum...
	for type in Global.summons.values():
		summons_container[type] = []
	spawn_summons(Global.summons.Cat, 2)
	spawn_summons(Global.summons.Spider, 2)
	spawn_summons(Global.summons.Mouse, 3)
	check_chimera_availability()
	
# Spawn a given numbers of summons of selected type
# Returns true if successful
func spawn_summons(type : Global.summons, count : int) -> bool:
	var ret = true
	for i in range(count):
		ret = ret and _spawn_one_summon(type)
	check_chimera_availability()
	return ret
		
func _spawn_summon_in_visual(new_summon, type : Global.summons) -> void:
		var _x : int = _pentagram_area.shape.size.x
		var _y : int = _pentagram_area.shape.size.y
		
		#var _width : int = _background_sprite.texture.get_width()
		#var _height : int = _background_sprite.texture.get_height()
			
		new_summon.position.x = randi_range(0, _x)
		new_summon.position.y = randi_range(0, _y)
		summons_container[type].append(new_summon)
		add_child(new_summon)
		print("Grrr")	


# Spawn one summon of a given type
# Returns true if successful
func _spawn_one_summon(type : Global.summons) -> bool:
	match type:
		Global.summons.Cat:
			var new_summon = _cat_class.instantiate()
			_spawn_summon_in_visual(new_summon, type)
			return true
		Global.summons.Spider:
			var new_summon = _spider_class.instantiate()
			_spawn_summon_in_visual(new_summon, type)
			return true
		Global.summons.Mouse:
			var new_summon = _mouse_class.instantiate()
			_spawn_summon_in_visual(new_summon, type)
			return true
		Global.summons.SpiderCat:
			var new_summon = _spidercat_class.instantiate()
			_spawn_summon_in_visual(new_summon, type)
			chimera_updated.emit(Global.summons.SpiderCat, get_number_of_summons(Global.summons.SpiderCat))
			return true
		Global.summons.CatMouse:
			var new_summon = _catmouse_class.instantiate()
			_spawn_summon_in_visual(new_summon, type)
			chimera_updated.emit(Global.summons.CatMouse, get_number_of_summons(Global.summons.CatMouse))
			return true
		Global.summons.MouseSpider:
			var new_summon = _mousespider_class.instantiate()
			_spawn_summon_in_visual(new_summon, type)
			chimera_updated.emit(Global.summons.MouseSpider, get_number_of_summons(Global.summons.MouseSpider))
			return true
		Global.summons.Demon:
			var new_summon = _demon_class.instantiate()
			_spawn_summon_in_visual(new_summon, type)
			chimera_updated.emit(Global.summons.Demon, get_number_of_summons(Global.summons.Demon))
			return true
	return false

# Destroy a given number of summons of given type
# Returns true if successful
func destroy_summons(type, count) -> bool:
	var ret = true;
	if get_number_of_summons(type) < count :
		return false
	for i in range(0, count):
		ret = ret and _destroy_one_summon(type)
	check_chimera_availability()
	return ret	

# Destroy one summon of given type
# Returns true if successful		
func _destroy_one_summon(type) -> bool:
	#TODO : kill a random instead of oldest ?
	var to_kill;
	match type:
		Global.summons.Cat:
			to_kill = summons_container[Global.summons.Cat]
		Global.summons.Spider:
			to_kill = summons_container[Global.summons.Spider]
		Global.summons.Mouse:
			to_kill = summons_container[Global.summons.Mouse]
		Global.summons.CatMouse:
			to_kill = summons_container[Global.summons.CatMouse]
		Global.summons.SpiderCat:
			to_kill = summons_container[Global.summons.SpiderCat]
		Global.summons.MouseSpider:
			to_kill = summons_container[Global.summons.MouseSpider]
		Global.summons.Demon:
			to_kill = summons_container[Global.summons.Demon]
	if to_kill and to_kill.size() > 0:
		remove_child(to_kill[0])
		to_kill.erase(to_kill[0])
		print("Ded")
		#send signals that chimera numbers have been updated
		match type:
			Global.summons.SpiderCat:
				chimera_updated.emit(Global.summons.SpiderCat, get_number_of_summons(Global.summons.SpiderCat))
				return true
			Global.summons.CatMouse:
				chimera_updated.emit(Global.summons.CatMouse, get_number_of_summons(Global.summons.CatMouse))
				return true
			Global.summons.MouseSpider:
				chimera_updated.emit(Global.summons.MouseSpider, get_number_of_summons(Global.summons.MouseSpider))
				return true
			Global.summons.Demon:
				chimera_updated.emit(Global.summons.Demon, get_number_of_summons(Global.summons.Demon))
				return true
		return true
	print("not ded")
	return false

#Returns the number of summons of a given type
func get_number_of_summons(type) -> int:
	if (type in summons_container.keys()):
		return summons_container[type].size()
	return 0
	
# Returns the total number of all summons
func get_number_of_all_summons() -> int:
	var ret := 0 
	for type in Global.summons:
		ret += get_number_of_summons(type)
	return ret
	
func check_chimera_availability():
	for chimera in Global.summons_requirements.keys():
		chimera_available.emit(chimera, check_one_chimera_availability(chimera))	
		
func check_one_chimera_availability(chimera):
	var is_available = true
	for creature in Global.summons_requirements[chimera].keys():	
		var count = get_number_of_summons(creature)
		var enough_creature = count >= Global.summons_requirements[chimera][creature]
		is_available = is_available and enough_creature
	return is_available

func create_chimera(_type : Global.summons, _count : int) -> bool:
	var ret = true
	print("create chimera")
	for i in range(_count):
		if (check_one_chimera_availability(_type)):
			ret = ret and _spawn_one_summon(_type)
			for creature in Global.summons_requirements[_type].keys():	
				ret = ret and destroy_summons(creature, Global.summons_requirements[_type][creature])
	return ret
