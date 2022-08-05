extends Node
var canvaslayer
var color_rect#black background
var debug_output
var debug_tween

var left_debug_stats
var right_debug_stats
var debug_input

#F6 to open debug console
#F4 to open stat panel
#örneğin Debug.add_stat("Velocity",self,"velocity",false)
var left_stats = []
var right_stats = []

onready var regular_font = load("res://regular_font.tres")

var commands
var command_history =[]
var command_history_line=0

var v_box_container
var buttons_scroll_container#todo bunun adını buttons_scroll_container yap
var command_suggestions =[]
var command_suggestions_line=0

var show_parametre_type=true

enum  {
	ARG_INT,
	ARG_STRING,
	ARG_BOOL,
	ARG_FLOAT
}

var valid_commands = [[self,"clear_output",[] ],[self,"clear_history",[]]]#eklemek için Debug.add_command(self,"func_name",[[Debug.ARG_INT]])

enum {DEFAULT,SUGGESTION_MODE,HISTORY_MODE,}

var console_mode=DEFAULT

var last_manually_changed_input_text=""

func _ready():
	add_stat("input_text",self,"last_manually_changed_input_text",false)
	add_stat("console_mode",self,"console_mode",false)
	create_ui()
	
	print(valid_commands)


func create_ui():
	canvaslayer=CanvasLayer.new()
	canvaslayer.layer=99
	add_child(canvaslayer)
	
	color_rect=ColorRect.new()
	color_rect.color=Color(0.160784, 0.160784, 0.160784, 0.466667)
	canvaslayer.add_child(color_rect)
	color_rect.anchor_bottom=1
	color_rect.anchor_right=1
	color_rect.anchor_top=0
	color_rect.anchor_left=0
	color_rect.margin_bottom=0
	color_rect.margin_left=0
	color_rect.margin_right=0
	color_rect.margin_top=0
	color_rect.visible=false
	
	left_debug_stats=Label.new()
	left_debug_stats.anchor_bottom=1
	left_debug_stats.anchor_right=1
	left_debug_stats.anchor_top=0
	left_debug_stats.anchor_left=0
	left_debug_stats.margin_bottom=0
	left_debug_stats.margin_left=0
	left_debug_stats.margin_right=0
	left_debug_stats.margin_top=0
	if regular_font!=null:
		left_debug_stats.set("custom_fonts/font",regular_font)
	canvaslayer.add_child(left_debug_stats)
	left_debug_stats.visible=false
	
	right_debug_stats=Label.new()
	right_debug_stats.anchor_bottom=1
	right_debug_stats.anchor_right=1
	right_debug_stats.anchor_top=0
	right_debug_stats.anchor_left=0
	right_debug_stats.margin_bottom=0
	right_debug_stats.margin_left=0
	right_debug_stats.margin_right=0
	right_debug_stats.margin_top=0
	if regular_font!=null:
		right_debug_stats.set("custom_fonts/font",regular_font)
	canvaslayer.add_child(right_debug_stats)
	right_debug_stats.align=right_debug_stats.ALIGN_RIGHT
	right_debug_stats.visible=false
	
	debug_tween= Tween.new()
	add_child(debug_tween)
	
	debug_output=RichTextLabel.new()
	debug_output.selection_enabled=true
	if regular_font!=null:
		debug_output.set("custom_fonts/normal_font",regular_font)
	debug_output.anchor_bottom=1
	debug_output.anchor_right=1
	debug_output.anchor_top=0
	debug_output.anchor_left=0
	debug_output.margin_bottom=-32
	debug_output.margin_left=0
	debug_output.margin_right=0
	debug_output.margin_top=0
	canvaslayer.add_child(debug_output)
	debug_output.visible=false
	debug_output.scroll_following=true;
	
	debug_input= LineEdit.new()
	
	debug_input.connect("text_changed",self,"debug_input_changed")
	debug_input.connect("text_entered",self,"debug_input_entered")
	var screen_height=  get_viewport().get_visible_rect().size.y
	debug_input.anchor_bottom=0#burdaki 16 input uzunluğu bundan sonra output başlıyor
	debug_input.anchor_right=1
	debug_input.anchor_top=(screen_height-32)/screen_height
	debug_input.anchor_left=0
	debug_input.margin_bottom=0
	debug_input.margin_left=0
	debug_input.margin_right=0
	debug_input.margin_top=0
	debug_input.visible=false
	debug_input.caret_blink=true
	debug_input.focus_mode=Control.FOCUS_CLICK
	if regular_font!=null:
		debug_input.set("custom_fonts/font",regular_font)
	canvaslayer.add_child(debug_input)
	
	
	#suggestion panel
	
	buttons_scroll_container=ScrollContainer.new()
	buttons_scroll_container.scroll_horizontal_enabled=false
	buttons_scroll_container.follow_focus=true
	buttons_scroll_container.anchor_bottom=1
	buttons_scroll_container.anchor_right=1
	buttons_scroll_container.anchor_top=0
	buttons_scroll_container.anchor_left=0
	buttons_scroll_container.margin_bottom=-32
	buttons_scroll_container.margin_left=0
	buttons_scroll_container.margin_right=0
	buttons_scroll_container.margin_top=0
	canvaslayer.add_child(buttons_scroll_container)
	v_box_container=VBoxContainer.new()
	v_box_container.alignment=BoxContainer.ALIGN_END
	v_box_container.size_flags_vertical=Control.SIZE_EXPAND_FILL
	buttons_scroll_container.add_child(v_box_container)
	buttons_scroll_container.visible=false


func debug_input_entered(text):
	if console_mode==HISTORY_MODE and text=="" and command_history_line < command_history.size() and command_history.size() > 0:
		debug_input.text=command_history[command_history_line]
	else:
		debug_input.text=""
		
	process_command(text)
	console_mode=DEFAULT
	command_history_line = command_history.size()
	buttons_scroll_container.visible=false
	if debug_input.text=="":
		show_history()

func debug_input_changed(text):
	if text=="":
		console_mode=DEFAULT
		buttons_scroll_container.visible=false
		show_history()
	elif last_manually_changed_input_text ==text:
		console_mode=console_mode
	else:
		console_mode=DEFAULT
	
	if console_mode==DEFAULT and text!="" :
		suggest_command(text)



func is_debug_console_opened():
	return debug_output.visible

func _input(event):
	if Input.is_action_just_pressed("console"):
		debug_output.visible=!debug_output.visible
		debug_input.visible=debug_output.visible
		color_rect.visible=debug_output.visible
		if debug_output.visible:#görsel efekt
			debug_input.grab_focus()
			debug_input.text=""
		else:
			buttons_scroll_container.visible=false
		
	if Input.is_action_just_pressed("stats"):
		left_debug_stats.visible=!left_debug_stats.visible
		right_debug_stats.visible=left_debug_stats.visible
	
	if debug_input.visible==false:
		return
	
	if event is InputEventKey and event.is_pressed():
		if debug_input.has_focus() :
			if event.scancode == KEY_UP:
				if (console_mode==DEFAULT and debug_input.text!="") or console_mode==SUGGESTION_MODE:
					goto_suggestions(-1)
				elif console_mode==HISTORY_MODE or (console_mode==DEFAULT and debug_input.text==""):
					goto_command_history(-1)
			if event.scancode == KEY_DOWN:
				if (console_mode==DEFAULT and debug_input.text!="") or console_mode==SUGGESTION_MODE:
					goto_suggestions(1)
				elif console_mode==HISTORY_MODE or (console_mode==DEFAULT and debug_input.text==""):
					goto_command_history(1)

func add_stat(stat_name, object, stat_ref, is_method,is_left=true):
	if is_left:
		left_stats.append([stat_name, object, stat_ref, is_method])
	else:
		right_stats.append([stat_name, object, stat_ref, is_method])

func _physics_process(delta):
	if left_debug_stats.visible==false:
		return
	calc_stats(left_debug_stats,left_stats)
	calc_stats(right_debug_stats,right_stats)

func calc_stats(_label,_stats):
	var label_text = ""
	
	if _label==left_debug_stats:
		var fps = Engine.get_frames_per_second()
		label_text += str("FPS: ", fps)
		label_text += "\n"
		var mem = OS.get_static_memory_usage()
		label_text += str("Static Memory: ", String.humanize_size(mem))
		label_text += "\n"
	

	for index in range(_stats.size()):
		var value = null
		var s=_stats[index]
		
		if  is_instance_valid(s[1]):
			if s[3]:
				value = s[1].call(s[2])
			else:
				value = s[1].get(s[2])
		else:
			#todo bu harbiden var mı yok mu kontrol etmiyor 
			#o yüzden statsdan silmiyor
			put_log(s+" is deleted")
			_stats.remove(index)
			return
		label_text += str(s[0], ": ",value )
		label_text += "\n"
#		for channel in FileSending.channel_infos:
#			label_text+=str(channel)+ " channel: " + str(FileSending.channel_infos[channel])
#			"\n"
	_label.text = label_text

func put_log(new_log):
	debug_output.text+="\n\n"+str(new_log)
	print(new_log)

func goto_command_history(offset):
	command_history_line += offset
	command_history_line = clamp(command_history_line, 0, command_history.size())
	if command_history_line < command_history.size() and command_history.size() > 0:
		console_mode=HISTORY_MODE
		var button = v_box_container.get_child(command_history_line)
		button.grab_focus()
		change_input(command_history[command_history_line])

func goto_suggestions(offset):
	command_suggestions_line += offset
	command_suggestions_line = clamp(command_suggestions_line, 0, command_suggestions.size())
	if command_suggestions_line < command_suggestions.size() and command_suggestions.size() > 0:
		console_mode=SUGGESTION_MODE 
		var button = v_box_container.get_child(command_suggestions_line)
		button.grab_focus()
		change_input(button.text)


func process_command(text):
	var words = text.split(" ",false)
	words = Array(words)
	
	for i in range(words.count("")):
		words.erase("")
	
	if words.size() == 0:
		return
	
	command_history.append(text)
	
	var command_word = words.pop_front()
	
	for c in valid_commands:
		if c[1] == command_word:
			if words.size() != c[2].size():
				put_log(str('Failure executing command "', command_word, '", expected ', c[2].size(), ' parameters'))
				return
			for i in range(words.size()):
				if not check_type(words[i], c[2][i]):
					put_log(str('Failure executing command "', command_word, '", parameter ', (i + 1),
								' ("', words[i], '") is of the wrong type'))
					return
			c[0].callv(command_word, words)
			return
	put_log(str('Command "', command_word, '" does not exist.'))


func check_type(string, type):
	if type == ARG_INT:
		return string.is_valid_integer()
	if type == ARG_FLOAT:
		return string.is_valid_float()
	if type == ARG_STRING:
		return true
	if type == ARG_BOOL:
		return (string == "true" or string == "false")
	return false

func get_type_name(type):
	if type == ARG_INT:
		return "int"
	if type == ARG_FLOAT:
		return "float"
	if type == ARG_STRING:
		return "string"
	if type == ARG_BOOL:
		return "bool"
	else:
		return "WRONG_TYPE"

func add_command(_object,_command_name,_args=[]):
	var new_command = [_object,_command_name,_args]
	
	valid_commands.append(new_command)

func clear_output():
	debug_output.text=""

func clear_history():
	command_history.clear()
	command_history_line=0

func suggest_command(text):
	command_suggestions.clear()
	command_suggestions_line=0
	for n in v_box_container.get_children():
		v_box_container.remove_child(n)
		n.queue_free()
	
	buttons_scroll_container.visible=true
	for command in valid_commands:
		if text in command[1]:
			command_suggestions.append(text)
			var button = Button.new() 
			button.align=Button.ALIGN_LEFT
			button.modulate=Color(1,1,1,0.5)
			button.connect("button_up",self,"change_input",[command[1]])
			var button_text =  command[1]
			
			if show_parametre_type:
				for arg in command[2]:
					button_text+=" "+get_type_name(arg)  
			
			button.text=button_text
			
			v_box_container.add_child(button)
	
	if v_box_container.get_children().size()==0:
		buttons_scroll_container.visible=false



func show_history():
	command_history_line=0
	for n in v_box_container.get_children():
		v_box_container.remove_child(n)
		n.queue_free()
	
	buttons_scroll_container.visible=true
	var last_button
	for command in command_history:
		
		var button = Button.new() 
		button.align=Button.ALIGN_LEFT
		button.modulate=Color(1,1,1,0.5)
		button.connect("button_up",self,"change_input",[command])
		button.text=command
		v_box_container.add_child(button)
		last_button=button
	
	if v_box_container.get_children().size()==0:
		buttons_scroll_container.visible=false
	else:
		command_history_line= v_box_container.get_children().size()
	
	
	if is_instance_valid(last_button):
		last_button.call_deferred("grab_focus")
		debug_input.call_deferred("grab_focus")



func change_input(text):
	last_manually_changed_input_text=text
	debug_input.text=text
	debug_input.grab_focus()
	debug_input.call_deferred("set_cursor_position", debug_input.text.length())

