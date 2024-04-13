extends Node

signal timeout

const TIME_PERIOD = 1 # 1s

var time = 0

var nb_spiders;
var nb_mice;
var nb_cats;

var nb_spider_cat;
var nb_spider_mouse;
var nb_cat_mouse;

var nb_demons;

var cats_for_spider_cat;
var spiders_for_spider_cat;
var spiders_for_spider_mouse;
var mouse_for_spider_mouse;
var cat_for_cat_mouse;
var mouse_for_cat_mouse;
var spider_cat_for_demons;
var spider_mouse_for_demons;
var cat_mouse_for_demons;

func _ready():
	nb_spiders = 0
	nb_mice = 0
	nb_cats = 0
	nb_spider_cat = 0
	nb_spider_mouse = 0
	nb_cat_mouse = 0
	nb_demons = 0
	
	cats_for_spider_cat = 1;
	spiders_for_spider_cat = 1;
	spiders_for_spider_mouse = 1;
	mouse_for_spider_mouse = 1;
	cat_for_cat_mouse = 1;
	mouse_for_cat_mouse = 1;
	spider_cat_for_demons = 1;
	spider_mouse_for_demons = 1;
	cat_mouse_for_demons  = 1;

func _process(delta):
	time += delta
	if time > TIME_PERIOD:
		emit_signal("timeout")
		# Reset timer
		time = 0
