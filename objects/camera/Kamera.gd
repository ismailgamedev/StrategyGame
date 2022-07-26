extends KinematicBody2D

var Vel = Vector2()

export (NodePath) var target
onready var Kamera = get_node("Camera2D")

var target_return_enabled = true
var target_return_rate = 0.02
var min_zoom = 0.2
var max_zoom = 0.8
var zoom_sensitivity = 10
var zoom_speed = 0.05

var events = {}
var last_drag_distance = 0

func _ready():
	visible = true

func _process(delta):
	Vel = move_and_slide(Vel)
	if target and target_return_enabled and events.size() == 0:
		position = lerp(position, get_node(target).position, target_return_rate)

func _input(event):
	#
	## bilgisayarlar icin yakinlasma sistemi ##
	#
	if Input.is_action_pressed("scroll_down"): # haritadan uzaklasir
		var new_zoom = 1 + zoom_speed
		new_zoom = clamp(Kamera.zoom.x * new_zoom, min_zoom, max_zoom)
		Kamera.zoom = Vector2.ONE * new_zoom

		pass
	if Input.is_action_pressed("scroll_up"): ## haritaya yaklasir
		var new_zoom = 1 - zoom_speed
		new_zoom = clamp(Kamera.zoom.x * new_zoom, min_zoom, max_zoom)
		Kamera.zoom = Vector2.ONE * new_zoom

		pass
	### -------- ###
	
	if event is InputEventScreenTouch:
		if event.pressed:
			events[event.index] = event
			
		else:
			events.erase(event.index)

	if event is InputEventScreenDrag:
		events[event.index] = event
		if events.size() == 1:
			position -= event.relative.rotated(rotation) * Kamera.zoom.x
		elif events.size() == 2:
			var drag_distance = events[0].position.distance_to(events[1].position)
			if abs(drag_distance - last_drag_distance) > zoom_sensitivity:
				var new_zoom = (1 + zoom_speed) if drag_distance < last_drag_distance else (1 - zoom_speed)
				new_zoom = clamp(Kamera.zoom.x * new_zoom, min_zoom, max_zoom)
				Kamera.zoom = Vector2.ONE * new_zoom
				last_drag_distance = drag_distance
