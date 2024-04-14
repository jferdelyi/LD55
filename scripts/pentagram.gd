extends Node


@onready var _cat_class := preload("res://scenes/creatures/cat.tscn")
@onready var _spider_class := preload("res://scenes/creatures/spider.tscn")
@onready var _mouse_class := preload("res://scenes/creatures/mouse.tscn")
@onready var _spidercat_class := preload("res://scenes/creatures/spidercat.tscn")
@onready var _mousespider_class := preload("res://scenes/creatures/mousespider.tscn")
@onready var _catmouse_class := preload("res://scenes/creatures/catmouse.tscn")
@onready var _demon_class := preload("res://scenes/creatures/demon.tscn")

#@onready var _background_sprite := $Background
@onready var _pentagram_area := $Area2D/CollisionShape2D

var summons_container = {}

signal chimera_available
signal chimera_updated

func _ready():
	#TODO : doute ici sur le .values() du enum...
	for type in Global.summons.values():
		summons_container[type] = []
	#spawn_summons(Global.summons.Cat, 6)
	#spawn_summons(Global.summons.Spider, 6)
	#spawn_summons(Global.summons.Mouse, 6)
	#spawn_summons(Global.summons.Demon, 0)
	check_chimera_availability()
	
func _process(delta):
	check_chimera_availability()
	chimera_updated.emit(Global.summons.SpiderCat, get_number_of_summons_inside_circle(Global.summons.SpiderCat))
	chimera_updated.emit(Global.summons.CatMouse, get_number_of_summons_inside_circle(Global.summons.CatMouse))
	chimera_updated.emit(Global.summons.MouseSpider, get_number_of_summons_inside_circle(Global.summons.MouseSpider))
	chimera_updated.emit(Global.summons.Demon, get_number_of_summons_inside_circle(Global.summons.Demon))
	
	
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
			
		new_summon.position.x = randi_range(-int(_x/2.0), int(_x/2.0))
		new_summon.position.y = randi_range(-int(_y/2.0), int(_y/2.0))
		summons_container[type].append(new_summon)
		add_child(new_summon)


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
			return true
		Global.summons.CatMouse:
			var new_summon = _catmouse_class.instantiate()
			_spawn_summon_in_visual(new_summon, type)
			return true
		Global.summons.MouseSpider:
			var new_summon = _mousespider_class.instantiate()
			_spawn_summon_in_visual(new_summon, type)
			return true
		Global.summons.Demon:
			var new_summon = _demon_class.instantiate()
			_spawn_summon_in_visual(new_summon, type)
			return true
	return false

# Destroy a given number of summons of given type
# if inside_circle is true, can destroy 
# Returns true if successful
func destroy_summons(type, count, inside_circle : bool) -> bool:
	var ret = true;
	if get_number_of_summons(type) < count :
		return false
	for i in range(0, count):
		ret = ret and _destroy_one_summon(type, inside_circle)
	check_chimera_availability()
	return ret	

# Destroy one summon of given type
# Returns true if successful		
func _destroy_one_summon(type, inside_circle : bool) -> bool:
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
		if remove_first_creature_inside_circle(to_kill):
			return true
	return false
	
func remove_first_creature_inside_circle(array) -> bool:
	for creature in array:
		if is_inside_pentagram(creature):
			remove_child(creature)
			array.erase(creature)
			return true			
	return false

#Returns the number of summons of a given type
func get_number_of_summons(type) -> int:
	if (type in summons_container.keys()):
		return summons_container[type].size()
	return 0
	
func is_inside_pentagram(creature) -> bool:
	var w = 0.5 * _pentagram_area.shape.size.x
	var h = 0.5 * _pentagram_area.shape.size.y
	var x = creature.position.x
	var y = creature.position.y
	#Point (x,y) is inside ellipsoid of center (h,k) and semi-axis (a, b) if
	# (x - h)² / a² + (y - k)² / b² <= 1
	const margin := 1.25
	var is_inside = (x * x) / (w * w) + (y * y) / (h * h) <= (1 * margin)
	return is_inside
	
	#Returns the number of summons of a given type
func get_number_of_summons_inside_circle(type) -> int:
	var ret = 0
	if (type in summons_container.keys()):
		for creature in summons_container[type]:
			if is_inside_pentagram(creature):
				ret += 1
	return ret
	
# Returns the total number of all summons
func get_number_of_all_summons() -> int:
	var ret := 0 
	for type in Global.summons:
		ret += get_number_of_summons(type)
	return ret
	
func get_number_of_all_summons_inside_circle() -> int:
	var ret := 0 
	for type in Global.summons:
		ret += get_number_of_summons_inside_circle(type)
	return ret
		
func check_chimera_availability():
	for chimera in Global.summons_requirements.keys():
		chimera_available.emit(chimera, check_one_chimera_availability(chimera))	
		
func check_one_chimera_availability(chimera):
	var is_available = true
	for creature in Global.summons_requirements[chimera].keys():	
		var count = get_number_of_summons_inside_circle(creature)
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
				ret = ret and destroy_summons(creature, Global.summons_requirements[_type][creature], true)
	return ret
