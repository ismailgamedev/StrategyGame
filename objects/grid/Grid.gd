extends Area2D

onready var building_sprite = get_node("BuildingSprite")


func _on_Grid_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			pass
