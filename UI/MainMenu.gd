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
	$PlayBtn.text = tr("playbtn")
	$AboutMenuBtn.text = tr("aboutbtn")
	$SettingsBtn.text = tr("settingsbtn")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Game/World.tscn")
	pass # Replace with function body.


func _on_AboutMenuBtn_pressed():
	pass # Replace with function body.


func _on_Settings_pressed():
	pass # Replace with function body.
