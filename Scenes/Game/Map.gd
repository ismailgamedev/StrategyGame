extends YSort

func _ready():
	
	_load_map()
	pass

var dataArray = []
var dataArray2 = []
var dataArray3 = []

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		
		_save_map()
		get_tree().quit()
	pass

func _save_map():
	for i in get_child_count():
		for i2 in get_child(i).get_child_count():
			dataArray.append(get_child(i).get_child(i2).current_building)
			dataArray2.append(get_child(i).get_child(i2).is_building)
			dataArray3.append(get_child(i).get_child(i2).InsayaKalanSure)
			pass
		pass
	print(dataArray,dataArray2,dataArray3)
	DataHandler._save_map(dataArray,dataArray2,dataArray3)
	pass

func _load_map():
	DataHandler._load_map(get_path())
	pass
