extends Area2D

onready var building_sprite = get_node("BuildingSprite")
onready var building_timer = get_node("binaTimer")
onready var nowbuildingicon = get_node("BuildingShits")
onready var platform = get_node("Platform")
#Textures
onready var kucuk_ev_texture = preload("res://assets/sprites/buildings/ev2.png")
onready var orta_ev_texture = preload("res://assets/sprites/buildings/ev4.png")
onready var buyuk_ev_texture = preload("res://assets/sprites/buildings/apartman.png")
#Grid Building Type

enum current_building_enum { bos,kucuk_ev,orta_ev,buyuk_ev,fabrika,petrol_donusturucusu,biyo_yakit_donusturucusu, }
export(current_building_enum) var current_building = current_building_enum.bos

var is_building : bool

func _process(delta):
	if is_building == false:
		nowbuildingicon.visible = false
		building_sprite.modulate = Color(1, 1, 1)
	else:
		nowbuildingicon.visible = true
		nowbuildingicon.get_node("timer_label").text = str(int(building_timer.time_left))
		building_sprite.modulate = Color(1, 1, 1, 0.3)
	if Globals.current_building != Globals.current_building_enum.bos:
		platform.modulate = Color(0.203922, 0.490196, 0.203922)
	else:
		platform.modulate = Color(1, 1, 1)
		

func _on_Grid_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			# Eger insaa ettigimiz bina yoksa girmiyoruz
			if Globals.current_building != Globals.current_building_enum.bos and current_building == current_building_enum.bos:
				create_building()

func create_building():
	if Globals.current_building == Globals.current_building_enum.kucuk_ev and Globals.data["dolar"] >= 20:
		building_sprite.texture = kucuk_ev_texture
		current_building = current_building_enum.kucuk_ev
		Globals.current_building = Globals.current_building_enum.bos
		is_building = true
		building_timer.start(8)
		Globals.data["dolar"] -= 20

	if Globals.current_building == Globals.current_building_enum.orta_ev and Globals.data["dolar"] >= 40:
		building_sprite.texture = orta_ev_texture
		current_building = current_building_enum.orta_ev
		Globals.current_building = Globals.current_building_enum.bos
		building_timer.start(8)
		is_building = true
		Globals.data["dolar"] -= 40

	if Globals.current_building == Globals.current_building_enum.buyuk_ev and Globals.data["dolar"] >= 100:
		building_sprite.texture = buyuk_ev_texture
		current_building = current_building_enum.buyuk_ev
		Globals.current_building = Globals.current_building_enum.bos
		is_building = true
		building_timer.start(8)
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
		

