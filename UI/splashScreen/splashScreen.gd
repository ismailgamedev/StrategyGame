extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("open")
	pass # Replace with function body.

func _physics_process(delta):
	if $AnimationPlayer.is_playing()== false:
		get_tree().change_scene("res://UI/MainMenu.tscn")
	pass
