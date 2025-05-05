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
	var local_next_id:int = id
	if local_next_id < 0:
		local_next_id = shader.get_valid_node_id(phase)
	shader.add_node(phase, node, Vector2.ZERO, local_next_id)
	
	return local_next_id

func remove_node(
	shader:VisualShader,
	node_id:int,
	phase:VisualShader.Type = VisualShader.TYPE_FRAGMENT):
	shader.remove_node(phase, node_id)
	

func p(message):
	$TextEdit.text += str(message) + '\n'

func _show_shader(shader:VisualShader) -> void:
	p(shader.code)
	var mat:ShaderMaterial = ShaderMaterial.new()
	mat.shader = shader
	ui_material_showcase.material = mat

func _ready():
	var shader:VisualShader = VisualShader.new()
	shader.mode = VisualShader.MODE_CANVAS_ITEM

	# Prepare Library
	var node_library := SimpleNodesLibrary.new()
	node_library.load_json_libraries_from_directory("res://test_files")

	# La bibliothèque ne doit pas contenir des noeuds mais plutôt
	# des Factory dont les définitions sont récupérées à la création.
	# Ces Factory peuvent à la fois :
	# - Instancier un noeud à partir d'une définition
	# - Adapter un noeud à partir d'une définition

	var acos_node:MyyVisualShaderDynamicNode = node_library.retrieve_default_for_method("acos")

	# Add shader Nodes
	var acos_id := add_node(shader, acos_node)

	# Print signatures
	var acos_factory := node_library.get_factory(acos_node.en_name)
	if acos_factory != null:
		for signature in acos_factory.signatures:
			print_debug(signature)

	# Connect them
	#var acos_node_outputs := acos_node.get_outputs()
	
	#acos_node_outputs[0].type = VisualShaderNode.PortType.PORT_TYPE_VECTOR_3D
	acos_factory.swap_node_signature(acos_node, 2)
	acos_node._set_option_index(0, 0)
	shader.connect_nodes(VisualShader.TYPE_FRAGMENT,acos_id, 0, 0, 0)
	p(shader.code)
