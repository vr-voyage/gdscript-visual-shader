extends Control

@export var ui_material_showcase:Control

var _next_id = 2
var next_id:int:
	get:
		var ret_id = _next_id
		_next_id += 1
		return ret_id

func add_node(
	shader:VisualShader,
	node:VisualShaderNode,
	phase:VisualShader.Type = VisualShader.TYPE_FRAGMENT,
	id:int = -1) -> int:
	var next_id:int = id
	if next_id < 0:
		next_id = shader.get_valid_node_id(phase)
	shader.add_node(phase, node, Vector2.ZERO, next_id)
	return next_id

func remove_node(
	shader:VisualShader,
	node_id:int,
	phase:VisualShader.Type = VisualShader.TYPE_FRAGMENT):
	shader.remove_node(phase, node_id)
	

func p(message):
	$TextEdit.text += str(message) + '\n'

func _load_node_from_json(json_filepath:String) -> MyyVisualShaderDynamicNode:
	var node := MyyVisualShaderDynamicNode.new()
	var node_file_content := FileAccess.get_file_as_string(json_filepath)
	if node_file_content == null:
		p("Can't open file")
		return null
	if node.load_definition_json(node_file_content) == false:
		return null
	return node

func _load_library(dirpath:String) -> Dictionary:
	var nodes:Dictionary = {}
	var dir := DirAccess.open(dirpath)
	if dir == null:
		printerr("Could not open folder")
		return nodes
	dir.list_dir_begin()
	for file: String in dir.get_files():
		if !file.get_extension().to_lower() == "json":
			continue
		var node := _load_node_from_json(dirpath + '/' + file)
		if node == null:
			continue
		nodes[node.en_name] = node
	return nodes

func _show_shader(shader:VisualShader) -> void:
	p(shader.code)
	var mat:ShaderMaterial = ShaderMaterial.new()
	mat.shader = shader
	ui_material_showcase.material = mat

func _ready():
	var shader:VisualShader = VisualShader.new()
	shader.mode = VisualShader.MODE_CANVAS_ITEM

	# Prepare Library
	var node_library:Dictionary = _load_library("res://test_files")
	var sin_node:MyyVisualShaderDynamicNode = node_library["acos"]
	var time_node:MyyVisualShaderDynamicNode = node_library["time"]

	# Add shader Nodes
	var sin_id := add_node(shader, sin_node)
	var time_id = add_node(shader, time_node)

	# Connect them
	shader.connect_nodes(VisualShader.TYPE_FRAGMENT,sin_id, 0, 0, 0)
	shader.connect_nodes(VisualShader.TYPE_FRAGMENT,time_id, 0, sin_id, 0)
	sin_node.emit_changed()

	# Show the result
	_show_shader(shader)
