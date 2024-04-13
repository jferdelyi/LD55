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

func _ready():
	nb_spiders = 0
	nb_mice = 0
	nb_cats = 0
	nb_spider_cat = 0
	nb_spider_mouse = 0
	nb_cat_mouse = 0
	nb_demons = 0

func _process(delta):
	time += delta
	if time > TIME_PERIOD:
		emit_signal("timeout")
		# Reset timer
		time = 0
