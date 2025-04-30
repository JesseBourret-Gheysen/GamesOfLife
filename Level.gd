extends Node2D

onready var PLAYER = preload("res://Player.tscn")

func _ready():
#	print('were ready')
	var player = PLAYER.instance()
	self.add_child(player)
	var Map : TileMap = get_node("TileMap")
	var width = Map.width * 8
	var height = Map.height * 8
	player.set_position(Vector2(width, height))
	
	var rect = Map.get_used_rect()
	var cell_size = Map.cell_size
	var center: Vector2 = Vector2(floor(rect.size.x/2), floor(rect.size.y))
	Map.set_cellv(center, 1-Map.get_cellv(center))
	Map.set_cellv(center-Vector2(2,2), 1-Map.get_cellv(center-Vector2(2,2)))
	Map.set_cellv(center+Vector2(2,2), 1-Map.get_cellv(center+Vector2(2,2)))

