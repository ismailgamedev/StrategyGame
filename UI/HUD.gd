extends Control

var build_btn_bool = false
var evmenu_btn_bool = false
var elektirikmenu_btn_bool = false

onready var money_label = get_node("Money/MoneyLabel")
onready var nufus_label = get_node("Nufus/NufusLabel")
onready var elektirik_label = get_node("Elektirik/ElektirikLabel")
onready var yemek_label = get_node("Yemek/YemekLabel")
onready var su_label = get_node("Su/SuLabel")
onready var mutluluk_label = get_node("Mutluluk/MutlulukLabel")
onready var anim_player = get_node("AnimationPlayer")
onready var ev_menu_btn = get_node("Control/EvMenuBtn")


func _on_BuildBtn_pressed():
	if build_btn_bool == false:
		anim_player.play("buildbtnpressanim")
		build_btn_bool = true
	elif build_btn_bool == true and evmenu_btn_bool == true:
		anim_player.play_backwards("evmenubtn")
		yield(anim_player,"animation_finished")
		evmenu_btn_bool = false
		Globals.current_building = Globals.current_building_enum.bos
		anim_player.play_backwards("buildbtnpressanim")
		build_btn_bool = false
	elif build_btn_bool == true and elektirikmenu_btn_bool == true:
		anim_player.play_backwards("elektirikmenu")
		yield(anim_player,"animation_finished")
		elektirikmenu_btn_bool  = false
		Globals.current_building = Globals.current_building_enum.bos
		anim_player.play_backwards("buildbtnpressanim")
		build_btn_bool = false
	elif build_btn_bool == true: 
		Globals.current_building = Globals.current_building_enum.bos
		anim_player.play_backwards("buildbtnpressanim")
		build_btn_bool = false
	
func _process(delta):
	money_label.text = str(Globals.data["dolar"])
	nufus_label.text = str(Globals.data["nufus"])
	elektirik_label.text = str(Globals.data["enerji"])
	yemek_label.text = str(Globals.data["yemek"])
	su_label.text = str(Globals.data["su"])
	mutluluk_label.text = str(Globals.data["mutluluk"])
	
func _on_EvMenuBtn_pressed():
	if evmenu_btn_bool == false and elektirikmenu_btn_bool == false:
		anim_player.play("evmenubtn")
		evmenu_btn_bool = true
	elif evmenu_btn_bool == true and elektirikmenu_btn_bool == false:
		evmenu_btn_bool = false
		Globals.current_building = Globals.current_building_enum.bos
		anim_player.play_backwards("evmenubtn")

func _on_ElektirikMenuBtn_pressed():
	if elektirikmenu_btn_bool == false and evmenu_btn_bool == false:
		anim_player.play("elektirikmenu")
		elektirikmenu_btn_bool = true
	elif elektirikmenu_btn_bool == true and evmenu_btn_bool == false:
		elektirikmenu_btn_bool = false
		Globals.current_building = Globals.current_building_enum.bos
		anim_player.play_backwards("elektirikmenu")
		
		
func _on_KucukEvBtn_pressed():
	if Globals.data["dolar"] >= 20:
		Globals.current_building = Globals.current_building_enum.kucuk_ev

func _on_OrtaEvBtn_pressed():
	if Globals.data["dolar"] >= 40:
		Globals.current_building = Globals.current_building_enum.orta_ev

func _on_ElektirikSantraliBtn_pressed():
	if Globals.data["dolar"] >= 200:
		Globals.current_building = Globals.current_building_enum.elektirik_santrali
