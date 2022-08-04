extends Node
var fileName = "data.save"
var fileName2 = "time.save"
var filePath = "user://"



var Mapfile1 =  "mapFile1.save"
var Mapfile2 = "mapFile2.save"
var Mapfile3 = "mapFile3.save"
var password = "MID_Beetlejuicetr"

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		
		
		#print(recentTimeGlobal)
		DataHandler._save_time()
		DataHandler._save()
		
		get_tree().quit()
	pass





func _save():
	var file = File.new()
	file.open_encrypted_with_pass(filePath+fileName,File.WRITE,password)
	file.store_var(Globals.data)
	pass

func _load():
	var file = File.new()
	if !file.file_exists(filePath+fileName):
		_save()
	else:
		
		file.open_encrypted_with_pass(filePath+fileName,File.READ,password)
		Globals.data = file.get_var()
	pass


func _save_time():
	var file = File.new()
	TimeHandler.httpRequest.request("http://worldtimeapi.org/api/timezone/Europe/Istanbul")
	
	file.open_encrypted_with_pass(filePath+fileName2,File.WRITE,password)
	file.store_var(TimeHandler.recentTimeGlobal)
	
	pass

func _load_time():
	
	var file = File.new()
	if !file.file_exists(filePath+fileName2):
		_save()
	else:
		file.open_encrypted_with_pass(filePath+fileName2,File.READ,password)
		TimeHandler.recentTimeGlobal = file.get_var()
	
	pass



func _save_map(Data1: Array,Data2: Array,Data3: Array):
	var file = File.new()
	file.open_encrypted_with_pass(filePath+Mapfile1,File.WRITE,password)
	file.store_var(Data1)
	file.close()
	
	file.open_encrypted_with_pass(filePath+Mapfile2,File.WRITE,password)
	file.store_var(Data2)
	file.close()
	
	file.open_encrypted_with_pass(filePath+Mapfile3,File.WRITE,password)
	file.store_var(Data3)
	file.close()
	pass


func _load_map(who):
	
	var geciciDegisken = []
	var geciciDegisken2 = []
	var geciciDegisken3 = []
	var file = File.new()
	if !file.file_exists(filePath+Mapfile1):
		print("kayit Dosyasi ' ",filePath+Mapfile1," ' konumunda bulunamadi !")
		pass
	
	else:
		file.open_encrypted_with_pass(filePath+Mapfile1,File.READ,password)
		geciciDegisken = file.get_var()
		file.close()
		
		file.open_encrypted_with_pass(filePath+Mapfile2,File.READ,password)
		geciciDegisken2 = file.get_var()
		file.close()
		
		file.open_encrypted_with_pass(filePath+Mapfile3,File.READ,password)
		geciciDegisken3 = file.get_var()
		file.close()
		
		for i in get_node(who).get_child_count():
			# 4
			print(get_node(who).get_child(i).name)
			for i2 in get_node(who).get_child(i).get_child_count():
				
#				get_node(who).get_child(i).get_child(i2).current_building = geciciDegisken[i2]
#				get_node(who).get_child(i).get_child(i2).is_building = geciciDegisken2[i2]
				get_node(who).get_child(i).get_child(i2)._map_load(geciciDegisken[i2],geciciDegisken2[i2],geciciDegisken3[i2])
				
				pass
			pass
	
	pass
