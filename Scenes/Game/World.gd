extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.
var hileMenuAcik = false
var hileMenu
func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		if hileMenuAcik == false:
			hileMenu = preload("res://UI/hileMenusu/hileMenusu.tscn").instance()
			hileMenu.name = "HackMenu"
			add_child(hileMenu)
			hileMenuAcik = true
			
		else:
			hileMenuAcik = false
			get_node("HackMenu").queue_free()
		pass
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
