extends Node2D

var score;
var score_base;
var score_chimere;
var score_demon;
var connected;

# Called when the node enters the scene tree for the first time.
func _ready():
	score_chimere = 1;
	score_demon = 3;
	false;
	$ScoreImage.hide()

func start():
	score = 0;
	$ScoreImage/ScoreLabel.text = "Score : " + str(score);
	$ScoreImage/ScoreLabel.show()
	
	if (connected == true):
		Global.timeout.disconnect(_update)
	connected = true
	Global.timeout.connect(_update)
	$ScoreImage.show()

# Update score
func _update():
	score += (Global.nb_spider_mouse + Global.nb_spider_cat + Global.nb_cat_mouse) * score_chimere;
	score += Global.nb_demons * score_demon;
	$ScoreImage/ScoreLabel.text = "Score : " + str(score);
	$ScoreImage/ScoreLabel.show()
