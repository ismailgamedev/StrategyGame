extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var firebase = null

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	if Engine.has_singleton("Firebase"):
		firebase = Engine.get_singleton("Firebase")
		print("Loaded Firebase")
		if firebase:
			firebase.init(get_instance_id())
		firebase.cloudmessaging_subscribe_to_topic("topicName")
	
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
