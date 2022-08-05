extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	DataHandler._load_time()
	DataHandler._load()
	TimeHandler.httpRequest.request("http://worldtimeapi.org/api/timezone/Europe/Istanbul")
	print(TimeHandler.timeFinaly)
	Debug.add_command(self,"saypop",[])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func saypop():
	Debug.put_log("pop")

func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Game/World.tscn")
	pass # Replace with function body.
