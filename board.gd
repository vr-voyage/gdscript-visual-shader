extends Control

class_name Board

@export var board_resource:BoardRes
@export var board_savepath:String = "user://board.res"
@export var debug_text:Label
@export var nodes_origin:Control
@export var board_node_template:PackedScene
@export var node_info_panel:NodeInfoPanel

var move_origin:Vector2
var start_position:Vector2
var moving:bool = false

func load_board(filepath:String):
	var loaded_board:BoardRes = ResourceLoader.load(filepath) as BoardRes
	if loaded_board == null:
		loaded_board = BoardRes.new()
	board_resource = loaded_board
	refresh_board()

func remove_chidren(node:Node):
	var n_children = node.get_child_count()
	while(n_children != 0):
		n_children -= 1
		node.remove_child(node.get_child(n_children))

func refresh_board():
	remove_chidren(nodes_origin)
	for board_node_res in board_resource.board_nodes:
		var board_node:BoardNode = board_node_template.instantiate()
		board_node.node_res = board_node_res
		nodes_origin.add_child(board_node)
		board_node.display()
		board_node.board_node_selected.connect(display_node_details)

	p(str(len(board_resource.board_nodes)))

func save_board(filepath:String):
	p(str(ResourceSaver.save(board_resource, filepath)))

func p(message:String) -> void:
	if debug_text != null:
		debug_text.text = message

func _on_gui_input(event:InputEvent):
	if nodes_origin == null:
		p("Meep")
		return

	if event is InputEventScreenTouch:
		var touch = event as InputEventScreenTouch
		if touch == null:
			return

		moving = touch.pressed
		if moving:
			move_origin = touch.position
			start_position = nodes_origin.position
			p(str(move_origin))

	if event is InputEventScreenDrag:
		if !moving:
			return
		var drag = event as InputEventScreenDrag

		var offt = (drag.position - move_origin)
		nodes_origin.position = start_position + offt
		p(str(nodes_origin.position))

func add_node():
	board_resource.create_node()
	refresh_board()

func display_node_details(node:BoardNodeRes):
	node_info_panel.slide_in()
	node_info_panel.display_node(node)





func _ready():
	board_resource = BoardRes.new()
