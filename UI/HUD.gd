extends Control


onready var building_panel = get_node("BuildingsPanel")

func _on_BuildButton_pressed():
	building_panel.visible = !building_panel.visible
