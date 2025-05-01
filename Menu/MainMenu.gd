extends Control

export(int, 20, 400) var horizontal_size = 80 setget _on_HorzSpinBoxInput_value_changed
export(int, 20, 400) var vertical_size = 80 setget _on_VertSpinBoxInput_value_changed
export(int, 5, 50) var evolution_speed = 10 setget _on_EvoSpeedSpinBoxInput_value_changed
export(int, 1, 6) var scope = 2 setget _on_ScopeSpinBoxInput_value_changed

export(Array, int) var life2life_array = []
export(Array, int) var death2life_array = []
export(Array, int) var life2death_array = []

onready var HorzSpinBox: SpinBox = $MainVBox/HorzSizeBox/HorzSpinBoxInput
onready var VertSpinBox: SpinBox = $MainVBox/VertSizeBox/VertSpinBoxInput
onready var EvoSpeedSpinBox: SpinBox = $MainVBox/EvoSpeedBox/EvoSpeedSpinBoxInput
onready var ScopeSpeedSprinBox: SpinBox = $MainVBox/ScopeBox/ScopeSpinBoxInput

onready var warning_l2l: Label = $MainVBox/VBoxContainer5/HBoxContainer/Warning
onready var warning_d2l: Label = $MainVBox/VBoxContainer6/HBoxContainer/Warning
onready var warning_l2d: Label = $MainVBox/VBoxContainer7/HBoxContainer/Warning

onready var video_player: VideoPlayer = $VideoPlayer

func _on_VideoPlayer_finished():
	video_player.play()

func _on_HorzSpinBoxInput_value_changed(value):
	horizontal_size = int(value)


func _on_VertSpinBoxInput_value_changed(value):
	vertical_size = int(value)

func _on_EvoSpeedSpinBoxInput_value_changed(value):
	evolution_speed = int(value)

func _on_ScopeSpinBoxInput_value_changed(value):
	scope = int(value)

func _on_Life2LifeInput_text_changed(new_text):
	life2life_array = []
	var temp: Array = new_text.split(",", true)
	for element in temp:
		element = element.strip_edges()
		if element == "":
			continue
		if typeof(element) == TYPE_INT:
			life2life_array.append(int(element))
		else:
			warning_l2l.text = "Invalid input in Life2LifeInput: " + str(element)
			print("Invalid input in Life2LifeInput: ", element)
			break
	

func _on_Death2LifeInput_text_changed(new_text):
	death2life_array = []
	var temp: Array = new_text.split(",", true)
	for element in temp:
		element = element.strip_edges()
		if element == "":
			continue
		if typeof(element) == TYPE_INT:
			death2life_array.append(int(element))
		else:
			warning_l2l.text = "Invalid input in Death2LifeInput: " + str(element)
			print("Invalid input in Death2LifeInput: ", element)
			break


func _on_Life2DeathInput_text_changed(new_text):
	life2death_array = []
	var temp: Array = new_text.split(",", true)
	for element in temp:
		element = element.strip_edges()
		if element == "":
			continue
		if typeof(element) == TYPE_INT:
			life2death_array.append(int(element))
		else:
			warning_l2l.text = "Invalid input in Life2deathInput: " + str(element)
			print("Invalid input in Life2deathInput: ", element)
			break


func save_menu_selections(length: int, width: int, speed: int, scope_val: int):
	# Sections are:
		# Map, Algorithm, Speed
	var config = ConfigFile.new()

	config.set_value("Map", "length", length)
	config.set_value("Map", "width", width)
	config.set_value("Algorithm", "scope", scope_val)
	config.set_value("Speed", "speed", speed)
	config.set_value("Algorithm", "life2life", life2life_array)
	config.set_value("Algorithm", "death2life", death2life_array)
	config.set_value("Algorithm", "life2death", life2death_array)
	config.save("user://settings.cfg")

func _input(event):
	if event.is_action_pressed("minmaxScreen"):
		OS.window_fullscreen = !OS.window_fullscreen

func _on_Start_pressed():
	save_menu_selections(vertical_size, horizontal_size, evolution_speed, scope)
	var scene_change_val = get_tree().change_scene("res://Level.tscn")
	print(scene_change_val)
