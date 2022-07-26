extends Control

var build_btn_bool = false
var evmenu_btn_bool = false
onready var anim_player = get_node("AnimationPlayer")
onready var ev_menu_btn = get_node("Control/EvMenuBtn")


func _on_BuildBtn_pressed():
	if build_btn_bool == false:
		anim_player.play("buildbtnpressanim")
		build_btn_bool = true
	else:
		anim_player.play_backwards("evmenubtn")
		yield(anim_player,"animation_finished")
		anim_player.play_backwards("buildbtnpressanim")
		build_btn_bool = false
	


func _on_EvMenuBtn_pressed():
	if evmenu_btn_bool == false:
		anim_player.play("evmenubtn")
		evmenu_btn_bool = true
	else:
		anim_player.play_backwards("evmenubtn")
		evmenu_btn_bool = false


func _on_KucukEvBtn_pressed():
	Globals.current_building = Globals.current_building_enum.kucuk_ev
