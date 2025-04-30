extends TileMap


const TILE_SIZE = 16

var width = 128
var height = 128
var speed = 5
var scope = 1
var scope_list
var neighboor_life_array: Array
var neighboor_death_array: Array

var playing = false
var time = 0
onready var cam: Camera2D = $"../ZoomingCamera2D"


var temp_field 

func _ready():
	print("were a boota load deez")
	print(width)
	print(height)
	print(speed)
	print(scope)
	
	load_settings()
#	var varlist = load_settings()
#	print("hold up print list now")
#	print(varlist)
#	print("--------------------")
#	print("now thery loadeed")
	
	print(width)
	print(height)
	print(speed)
	print(scope)
	scope_list = scope_to_coord()

	
	var width_px = width * TILE_SIZE
	var height_px = height * TILE_SIZE
	
	cam.position = Vector2(width_px, height_px)/2
	cam.zoom = Vector2(width_px, height_px) / Vector2(1024, 768)

	temp_field = []
	for x in range(width):
		var temp = []
		for y in range(height):
			set_cell(x,y,0)
			temp.append(0)
		temp_field.append(temp)


func _input(event):
	if event.is_action_pressed("toggle_play"):
		playing = !playing
	if event.is_action_pressed("click"):
		print("clicking in the cellTileMapFile")
		var pos = (get_local_mouse_position()/TILE_SIZE).floor()
		print(pos)
		set_cellv(pos, 1-get_cellv(pos))
	if event.is_action_pressed("Zoom_Out"):
		print("zoom in")
		cam.zoom_in(Vector2(0,1))
	if event.is_action_pressed("Zoom_In"):
		print("zoom out")
		cam.zoom_out(Vector2(0,0))
	if event.is_action_pressed("minmaxScreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	if event.is_action_pressed("menu"):
		get_tree().change_scene("res://Menu/Main.tscn")
	if event.is_action_pressed("clear"):
		clear_field()


func _process(delta):
	time += speed * delta
	if time > 5:
		update_field()
		time = 0


func update_field():
	if !playing:
		return
	
	print("we are playing - in update_field()")
	#adjust state in temp_field
	for x in range(width):
		for y in range(height):
			var live_neighbors = 0
			for x_off in scope_list:
				for y_off in scope_list:
					if (x_off != y_off) or x_off !=0:
						if get_cell(x+x_off, y+y_off) == 1:
							live_neighbors += 1
							
			if get_cell(x, y) == 1:
				if live_neighbors in neighboor_life_array:
					temp_field[x][y] = 1
				else:
					temp_field[x][y] = 0
			else:
				if live_neighbors in neighboor_death_array:
					temp_field[x][y] = 1
				else:
					temp_field[x][y] = 0
	
	#update the tile map
	for x in range(width):
		for y in range(height):
			set_cell(x, y, temp_field[x][y])


func scope_to_coord():
	var li = []
	for i in range(-(scope),scope+1):
		li.append(i)
	return li


func load_settings():
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err == OK: # If not, something went wrong with the file loading
		print("config.load() worked")
		height = config.get_value("Map", "length", 128)
		width = config.get_value("Map", "width", 128)
		scope = config.get_value("Algorithm", "scope", 2)
		speed = config.get_value("Speed", "speed", 5)
		neighboor_life_array = config.get_value("Algorithm", "life", [3,4])
		neighboor_death_array = config.get_value("Algorithm", "death", [3,4])
		print("Life array")
		print(neighboor_life_array)
#		return [height, width, scope, speed]
	else:
		print("config.load() didn't work")


func clear_field():
	for x in range(width):
		for y in range(height):
			set_cell(x, y, 0)
