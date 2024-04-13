extends Node2D

var score;
var score_base;
var score_chimere;
var score_demon;

# Called when the node enters the scene tree for the first time.
func _ready():
	score_chimere = 1;
	score_demon = 3;
	
	Global.timeout.connect(_update)

func start():
	score = 0;
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Update score
func _update():
	score += (Global.nb_spider_mouse + Global.nb_spider_cat + Global.nb_cat_mouse) * score_chimere;
	score += Global.nb_demons * score_demon;
	print("update score ", score)
