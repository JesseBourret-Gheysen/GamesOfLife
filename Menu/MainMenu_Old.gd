extends Control

export(int) var horizontal_size = 80 setget _on_HorizontalSize_value_changed
export(int) var vertical_size = 80 setget _on_VerticalSize_value_changed
export(int) var evolution_speed = 10 setget _on_EvolutionSpeed_value_changed
export(int) var scope = 2 setget _on_Scope_value_changed

export(Array, int) var neighboor_life_array = []
export(Array, int) var neighboor_death_array = []

var l_box_1: int
var l_box_2: int
var l_box_3: int
var l_box_4: int
var l_box_5: int
var l_box_6: int
var l_box_7: int
var l_box_8: int
var l_box_9: int
var l_box_10: int
var l_box_11: int
var d_box_1: int
var d_box_2: int
var d_box_3: int
var d_box_4: int
var d_box_5: int
var d_box_6: int
var d_box_7: int
var d_box_8: int
var d_box_9: int
var d_box_10: int
var d_box_11: int

onready var horizontal_label: Label = $VBoxSliders/VBoxContainer/HorizontalSizeLabel
onready var vertical_label: Label = $VBoxSliders/VBoxContainer2/VerticalSizeLabel
onready var speed_label: Label = $VBoxSliders/VBoxContainer/EvolutionSpeedLabel
onready var scope_label: Label = $VBoxSliders/VBoxContainer/ScopeLabel
onready var video_player: VideoPlayer = $VideoPlayer


func _on_HorizontalSize_value_changed(value):
	horizontal_size = int(value)
#	horizontal_label.text = "Horizontal Size : " + str(horizontal_size)


func _on_VerticalSize_value_changed(value):
	vertical_size = int(value)
	#vertical_label.text = "this"
	#vertical_label.text = "Vertical Size : " + str(vertical_size)


func _on_EvolutionSpeed_value_changed(value):
	evolution_speed = int(value)
	print(value)
#	speed_label.text = "Evolution Speed : " + str(evolution_speed)


func _on_Scope_value_changed(value):
	scope = int(value)
	print(value)
#	scope_label.text = "Scope : " + str(scope)


func _on_Start_pressed():
	save_menu_selections(vertical_size, horizontal_size, evolution_speed, scope)
	var scene_change_val = get_tree().change_scene("res://Level.tscn")
	print(scene_change_val)


func save_menu_selections(length: int, width: int, speed: int, scope_val: int):
	# Sections are:
		# Map, Algorithm, Speed
	make_neighboor_array()
	var config = ConfigFile.new()

	config.set_value("Map", "length", length)
	config.set_value("Map", "width", width)
	config.set_value("Algorithm", "scope", scope_val)
	config.set_value("Speed", "speed", speed)
	config.set_value("Algorithm", "life", neighboor_life_array)
	config.set_value("Algorithm", "death", neighboor_death_array)

	config.save("user://settings.cfg")

func _input(event):
	if event.is_action_pressed("minmaxScreen"):
		OS.window_fullscreen = !OS.window_fullscreen

######################################
#### - input for neighbor/life - #####
######################################
func make_neighboor_array():
	if l_box_1:
		neighboor_life_array.append(l_box_1)
	if l_box_2:
		neighboor_life_array.append(l_box_2)
	if l_box_3:
		neighboor_life_array.append(l_box_3)
	if l_box_4:
		neighboor_life_array.append(l_box_4)
	if l_box_5:
		neighboor_life_array.append(l_box_5)
	if l_box_6:
		neighboor_life_array.append(l_box_6)
	if l_box_7:
		neighboor_life_array.append(l_box_7)
	if l_box_8:
		neighboor_life_array.append(l_box_8)
	if l_box_9:
		neighboor_life_array.append(l_box_9)
	if l_box_10:
		neighboor_life_array.append(l_box_10)
	if l_box_11:
		neighboor_life_array.append(l_box_11)
	if d_box_1:
		neighboor_death_array.append(d_box_1)
	if d_box_2:
		neighboor_death_array.append(d_box_2)
	if d_box_3:
		neighboor_death_array.append(d_box_3)
	if d_box_4:
		neighboor_death_array.append(d_box_4)
	if d_box_5:
		neighboor_death_array.append(d_box_5)
	if d_box_6:
		neighboor_death_array.append(d_box_6)
	if d_box_7:
		neighboor_death_array.append(d_box_7)
	if d_box_8:
		neighboor_death_array.append(d_box_8)
	if d_box_9:
		neighboor_death_array.append(d_box_9)
	if d_box_10:
		neighboor_death_array.append(d_box_10)
	if d_box_11:
		neighboor_death_array.append(d_box_11)

func _on_SpinBox_value_changed(value):
	l_box_1 = value


func _on_SpinBox2_value_changed(value):
	l_box_2 = value


func _on_SpinBox3_value_changed(value):
	l_box_3 = value


func _on_SpinBox4_value_changed(value):
	l_box_4 = value


func _on_SpinBox5_value_changed(value):
	l_box_5 = value


func _on_SpinBox6_value_changed(value):
	l_box_6 = value


func _on_SpinBox7_value_changed(value):
	l_box_7 = value


func _on_SpinBox8_value_changed(value):
	l_box_8 = value


func _on_SpinBox9_value_changed(value):
	l_box_9 = value


func _on_SpinBox10_value_changed(value):
	l_box_10 = value


func _on_SpinBox11_value_changed(value):
	l_box_11 = value

###### Start of the death list #####
func _on_SpinBoxDead_value_changed(value):
	d_box_1 = value


func _on_SpinBoxDead2_value_changed(value):
	d_box_2 = value


func _on_SpinBoxDead3_value_changed(value):
	d_box_3 = value


func _on_SpinBoxDead4_value_changed(value):
	d_box_4 = value


func _on_SpinBoxDead5_value_changed(value):
	d_box_5 = value


func _on_SpinBoxDead6_value_changed(value):
	d_box_6 = value


func _on_SpinBoxDead7_value_changed(value):
	d_box_7 = value


func _on_SpinBoxDead8_value_changed(value):
	d_box_8 = value


func _on_SpinBoxDead9_value_changed(value):
	d_box_9 = value


func _on_SpinBoxDead10_value_changed(value):
	d_box_10 = value


func _on_SpinBoDeadx11_value_changed(value):
	d_box_11 = value


func _on_VideoPlayer_finished():
	video_player.play()
