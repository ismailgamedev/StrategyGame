extends Node
var fileName = "data.save"
var fileName2 = "time.save"
var filePath = "user://"

var password = "MID_Beetlejuicetr"
func _save():
	var file = File.new()
	file.open_encrypted_with_pass(filePath+fileName,File.WRITE,password)
	file.store_var(Globals.data)
	pass

func _load():
	var file = File.new()
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
	file.open_encrypted_with_pass(filePath+fileName2,File.WRITE,password)
	TimeHandler.recentTimeGlobal = file.get_var()
	pass
