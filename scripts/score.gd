extends Node2D

var score;
var nb_spidermouse;
var nb_catmouse;
var nb_spidercat;
var nb_demon;
var coeff_chimere;
var coeff_demon;
var connected;

# Called when the node enters the scene tree for the first time.
func _ready():
	coeff_chimere = 1;
	coeff_demon = 5;
	nb_spidermouse = 0;
	nb_catmouse = 0;
	nb_spidercat = 0;
	nb_demon = 0;
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
	score += (nb_spidermouse + nb_spidercat + nb_catmouse) * coeff_chimere;
	score += nb_demon * coeff_demon;
	$ScoreImage/ScoreLabel.text = "Score : " + str(score);
	$ScoreImage/ScoreLabel.show()


func _on_pentagram_chimera_updated(type, nb):
	match type:
		Global.summons.SpiderCat:
			nb_spidercat = nb;
			return;
		Global.summons.CatMouse:
			nb_catmouse = nb;
			return;
		Global.summons.MouseSpider:
			nb_spidermouse = nb;
			return;
		Global.summons.Demon:
			nb_demon = nb;
			return;
