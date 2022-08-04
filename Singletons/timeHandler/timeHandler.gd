extends Node

onready var httpRequest = $HTTPRequest
func _ready():
	
	httpRequest.connect("request_completed", self, "_mevcut_tarih_saat")
	httpRequest.request("http://worldtimeapi.org/api/timezone/Europe/Istanbul")
	
	pass


var timeGlobal = {
	"hour":0,
	"minute":0,
	"second":0,
	"day":0,
	"month":07,
	"year":2022,
}


var recentTimeGlobal = {
	"hour":0,
	"minute":0,
	"second":0,
	"day":0,
	"month":07,
	"year":2022,
}

var timeFinaly = {
	"hour":08,
	"minute":04,
	"second":32,
	"day":27,
	"month":07,
	"year":2022,
}




func _mevcut_tarih_saat(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	timeGlobal.hour =int( json.result["datetime"].split("T")[1].split(".")[0].split(":")[0])
	timeGlobal.minute =int (json.result["datetime"].split("T")[1].split(".")[0].split(":")[1])
	timeGlobal.second = int(json.result["datetime"].split("T")[1].split(".")[0].split(":")[2])
	
	timeGlobal.day = int (json.result["datetime"].split("T")[0].split("-")[2])
	timeGlobal.month = int(json.result["datetime"].split("T")[0].split("-")[1])
	timeGlobal.year = int(json.result["datetime"].split("T")[0].split("-")[0])
	
	
	
	_gecen_zaman()
	TimeHandler.recentTimeGlobal = TimeHandler.timeGlobal
	pass



func _gecen_zaman():
	
	timeFinaly.month = timeGlobal.month - recentTimeGlobal.month
	timeFinaly.day = timeGlobal.day - recentTimeGlobal.day
	timeFinaly.hour = timeGlobal.hour - recentTimeGlobal.hour
	timeFinaly.minute = timeGlobal.minute - recentTimeGlobal.minute
	timeFinaly.second = timeGlobal.second - recentTimeGlobal.second
	timeFinaly.year = timeGlobal.year - recentTimeGlobal.year
	
	for i in timeFinaly:
		if timeFinaly[i] < 0:
			if i == "hour":
				var x = -timeFinaly[i]
				timeFinaly[i] = 24 - x
			if i == "minute":
				var x = -timeFinaly[i]
				timeFinaly[i] = 60 - x
			if i == "second":
				var x = -timeFinaly[i]
				timeFinaly[i] = 60 - x
			if i == "month":
				var x = -timeFinaly[i]
				timeFinaly[i] = 12 - x
			if i == "day":
				var x = -timeFinaly[i]
				timeFinaly[i] = 30 - x
	
	print("gecen zaman",timeFinaly)
	print("onceki giris",recentTimeGlobal)
	print("simdi ki saat",timeGlobal)

