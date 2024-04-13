extends Node2D


@onready var _score_label := $Score

func _ready():
	$ScoreScene.start()
