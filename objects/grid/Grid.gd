extends Area2D

onready var building_timer = get_node("binaTimer")
onready var nowbuildingicon = get_node("BuildingShits")
onready var platform = get_node("Platform")
#Textures
onready var animated_spirte = get_node("AnimatedSprite")
#Grid Building Type

enum current_building_enum { bos,kucuk_ev,orta_ev,buyuk_ev,elektirik_santrali,ruzgarturbini,gunes_paneli,sudepo }
export(current_building_enum) var current_building = current_building_enum.bos
var mapYuklendi = false

var is_building : bool
var InsayaKalanSure = 0
var enumToText = ["bos","kucuk_ev","orta_ev","buyuk_ev","elektirik_santrali","ruzgarturbini","gunes_paneli","sudepo"]

func _map_load(currentBuild,isBuild,timeLeft):
	
	current_building = current_building_enum[enumToText[currentBuild]]
	is_building = isBuild
	animated_spirte.play(enumToText[currentBuild])
	InsayaKalanSure = timeLeft
	if InsayaKalanSure > 0:
		print(InsayaKalanSure,"*-*",timeLeft,"*//",building_timer.time_left)
	
	mapYuklendi = true
	pass

func _physics_process(delta):
	if mapYuklendi:
		if is_building == false:
			nowbuildingicon.visible = false
			animated_spirte.modulate = Color(1, 1, 1)
		else:
			if building_timer.is_stopped() and is_building == true:
				_gecen_sure_hesaplamasi()
				building_timer.start(InsayaKalanSure)
				

			
			nowbuildingicon.visible = true
			nowbuildingicon.get_node("timer_label").text = str(int(building_timer.time_left))
			InsayaKalanSure = int(building_timer.time_left)
			animated_spirte.modulate = Color(1, 1, 1, 0.3)
	if Globals.current_building != Globals.current_building_enum.bos and current_building == current_building_enum.bos:
		platform.modulate = Color(0.203922, 0.490196, 0.203922)
		
	else:
		platform.modulate = Color(1, 1, 1)
	if Globals.current_building != Globals.current_building_enum.bos and current_building != current_building_enum.bos:
		platform.modulate = Color(1, 0, 0)
func _on_Grid_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			# Eger insaa ettigimiz bina yoksa girmiyoruz
			if Globals.current_building != Globals.current_building_enum.bos and current_building == current_building_enum.bos:
				create_building()
				print("CALİSMASI LAZIM")

func create_building():
	if Globals.current_building == Globals.current_building_enum.kucuk_ev and Globals.data["dolar"] >= 20:
		animated_spirte.play("kucuk_ev")
		current_building = current_building_enum.kucuk_ev
		Globals.current_building = Globals.current_building_enum.bos
		is_building = true
		building_timer.start(120)
		mapYuklendi = true
		print(building_timer.time_left)
		InsayaKalanSure = 120
		Globals.data["dolar"] -= 20

	if Globals.current_building == Globals.current_building_enum.orta_ev and Globals.data["dolar"] >= 40:
		animated_spirte.play("orta_ev")
		current_building = current_building_enum.orta_ev
		Globals.current_building = Globals.current_building_enum.bos
		building_timer.start(8)
		mapYuklendi = true
		InsayaKalanSure = 8
		is_building = true
		Globals.data["dolar"] -= 40

	if Globals.current_building == Globals.current_building_enum.buyuk_ev and Globals.data["dolar"] >= 100:
		animated_spirte.play("buyuk_ev")
		current_building = current_building_enum.buyuk_ev
		Globals.current_building = Globals.current_building_enum.bos
		is_building = true
		mapYuklendi = true
		building_timer.start(8)
		InsayaKalanSure = 8
		Globals.data["dolar"] -= 100
		
	if Globals.current_building == Globals.current_building_enum.elektirik_santrali and Globals.data["dolar"] >= 200:
		animated_spirte.play("elektirik_santrali")
		current_building = current_building_enum.elektirik_santrali
		Globals.current_building = Globals.current_building_enum.bos
		is_building = true
		mapYuklendi = true
		building_timer.start(8)
		InsayaKalanSure = 8
		Globals.data["dolar"] -= 200
		
	if Globals.current_building == Globals.current_building_enum.ruzgarturbini and Globals.data["dolar"] >= 150:
		animated_spirte.play("ruzgarturbini")
		current_building = current_building_enum.ruzgarturbini
		Globals.current_building = Globals.current_building_enum.bos
		is_building = true
		mapYuklendi = true
		building_timer.start(8)
		InsayaKalanSure = 8
		Globals.data["dolar"] -= 150
		
	if Globals.current_building == Globals.current_building_enum.gunes_paneli and Globals.data["dolar"] >= 100:
		animated_spirte.play("gunes_paneli")
		current_building = current_building_enum.ruzgarturbini
		Globals.current_building = Globals.current_building_enum.bos
		is_building = true
		mapYuklendi = true
		building_timer.start(8)
		InsayaKalanSure = 8
		Globals.data["dolar"] -= 100
		
	if Globals.current_building == Globals.current_building_enum.sudeposu and Globals.data["dolar"] >= 100:
		animated_spirte.play("sudepo")
		current_building = current_building_enum.sudepo
		Globals.current_building = Globals.current_building_enum.bos
		is_building = true
		mapYuklendi = true
		building_timer.start(8)
		InsayaKalanSure = 8
		Globals.data["dolar"] -= 100
		
func _on_binaTimer_timeout():
	if current_building == current_building_enum.kucuk_ev:
		is_building = false
		Globals.data["nufus"] += 4
		building_timer.stop()
	if current_building == current_building_enum.orta_ev:
		is_building = false
		Globals.data["nufus"] += 10
		building_timer.stop()
	if current_building == current_building_enum.buyuk_ev:
		is_building = false
		Globals.data["nufus"] += 20
		building_timer.stop()
	if current_building == current_building_enum.elektirik_santrali:
		is_building = false
		building_timer.stop()
	if current_building == current_building_enum.ruzgarturbini:
		is_building = false
		building_timer.stop()
	if current_building == current_building_enum.gunes_paneli:
		is_building = false
		building_timer.stop()
	if current_building == current_building_enum.sudepo:
		is_building = false
		building_timer.stop()



func _ready():
	pass

func _gecen_sure_hesaplamasi():
	
	if TimeHandler.timeFinaly["year"] >= 0:
		TimeHandler.timeFinaly["month"] += TimeHandler.timeFinaly["year"] * 12
	if TimeHandler.timeFinaly["month"] >=0:
		TimeHandler.timeFinaly["day"] += TimeHandler.timeFinaly["month"] * 30
	if TimeHandler.timeFinaly["day"] >=0:
		TimeHandler.timeFinaly["hour"] += TimeHandler.timeFinaly["day"] * 24
	if TimeHandler.timeFinaly["hour"] >=0:
		TimeHandler.timeFinaly["second"] += TimeHandler.timeFinaly["hour"] * 60
		pass
	var sonuc = InsayaKalanSure - TimeHandler.timeFinaly["second"]
	if sonuc <= 0:
		print(InsayaKalanSure,TimeHandler.timeFinaly["second"],"sifirden KUCUK",sonuc)
		InsayaKalanSure = 1
	else:
		print(InsayaKalanSure,TimeHandler.timeFinaly["second"])
		InsayaKalanSure = InsayaKalanSure - TimeHandler.timeFinaly["second"]
	pass
