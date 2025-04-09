extends GraphEdit

class_name MyyVisualShaderGraph

@export var shader_graph_node:PackedScene

@export var debug_output:Label
@export var debug_shader_output:Control

@export var popup_menu:PopupMenu

var id_generator:IdGenerator = IdGenerator.new()
var shader:VisualShader = VisualShader.new()

func refresh_preview():
	demo_shader(shader)

func demo_shader(shader_to_demo:VisualShader):
	if debug_shader_output == null:
		return
	shader_to_demo.emit_changed()
	var shader_code:String = shader_to_demo.code
	
	var mat:Material = ShaderMaterial.new()
	mat.shader = Shader.new()
	mat.shader.code = shader_code
	debug_shader_output.material = mat
	p(shader_code)

func p(content):
	if debug_output != null:
		debug_output.text = str(content) + "\n"

func next_id() -> int:
	return id_generator.generate_new_id()

func _on_shader_node_updated(_node:MyyVisualShaderGraphNode):
	print_debug("Updated !")
	refresh_preview()

func add_to_shader(node:MyyVisualShaderNode, visual_shader:VisualShader, shader_phase:VisualShader.Type):
	var node_id := visual_shader.get_valid_node_id(shader_phase)
	node.set_id(node_id)
	visual_shader.add_node(shader_phase, node, Vector2.ZERO, node_id)

func add_shader_node_to_graph(shader_node:MyyVisualShaderNode):
	if shader_node == null:
		return
	var graph_node = shader_graph_node.instantiate()
	graph_node.display(shader_node)
	add_child(graph_node)
	add_to_shader(shader_node, shader, VisualShader.TYPE_FRAGMENT)
	graph_node.shader_node_updated.connect(_on_shader_node_updated)
	refresh_preview()

func _ready():
	shader.mode = VisualShader.MODE_CANVAS_ITEM
	var gen_types := [
		VisualShaderNode.PORT_TYPE_SCALAR,
		VisualShaderNode.PORT_TYPE_VECTOR_2D,
		VisualShaderNode.PORT_TYPE_VECTOR_3D,
		VisualShaderNode.PORT_TYPE_VECTOR_4D
	]

	for gen_type_in in gen_types:
		for gen_type_out in gen_types:
			add_valid_connection_type(gen_type_in, gen_type_out)

	add_shader_node_to_graph(MyyVisualShaderNodeOutput.new(0))

func get_graph_node(node_name:String) -> MyyVisualShaderGraphNode:
	for child in get_children():
		if child.name == node_name:
			return child as MyyVisualShaderGraphNode
	return null

func _on_connection_request(from,output,to,input):
	var from_node:MyyVisualShaderGraphNode = get_graph_node(from) as MyyVisualShaderGraphNode
	var to_node:MyyVisualShaderGraphNode = get_graph_node(to) as MyyVisualShaderGraphNode

	if from_node == null or to_node == null:
		return

	var output_shader_id:int = from_node.shader_node.get_id()
	var input_shader_id:int = to_node.shader_node.get_id()

	var ret:int = shader.connect_nodes(VisualShader.TYPE_FRAGMENT, output_shader_id, output, input_shader_id, input) 

	if ret == OK:
		connect_node(from,output,to,input)
		refresh_preview()

func _on_disconnection_request(from,output,to,input):
	print_debug("Disconnection request")
	var from_node:MyyVisualShaderGraphNode = get_graph_node(from)
	var to_node:MyyVisualShaderGraphNode = get_graph_node(to)
	
	if from_node == null or to_node == null:
		return
	
	var output_shader_id:int = from_node.shader_node.get_id()
	var input_shader_id:int = to_node.shader_node.get_id()

	shader.disconnect_nodes(VisualShader.TYPE_FRAGMENT, output_shader_id, output, input_shader_id, input)
	disconnect_node(from, output, to, input)
	refresh_preview()

func _on_popup_request(_at_position:Vector2):
	popup_menu.popup_centered_ratio(0.7)
	pass # Replace with function body.
