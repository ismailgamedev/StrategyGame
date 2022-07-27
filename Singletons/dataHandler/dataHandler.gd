extends Node
var fileName = "data.save"
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
