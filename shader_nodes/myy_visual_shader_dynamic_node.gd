extends MyyVisualShaderNode

class_name MyyVisualShaderDynamicNode

var nodes_info:Dictionary = {}

func _set_nodes_info(info:Dictionary):
	nodes_info = info

static func from_json(json_content:String) -> MyyVisualShaderDynamicNode:
	var node := MyyVisualShaderDynamicNode.new()
	if node.load_definition_json(json_content) == false:
		return null
	return node

static func from_dictionary(dictionary:Dictionary) -> MyyVisualShaderDynamicNode:
	var node := MyyVisualShaderDynamicNode.new()
	if node.load_definition_dictionary(dictionary) == false:
		return null
	return node

func load_definition_dictionary(parsed_node:Dictionary) -> bool:
	if not parsed_node.has_all(["name", "category", "description", "inputs", "outputs","code"]):
		return false

	var node_name:String = parsed_node["name"]
	var node_code:String = parsed_node["code"]
	var node_description:String = parsed_node["description"]
	var node_category:String = parsed_node["category"]
	var node_input_slots:Array[MyyVisualShaderNodePort] = []
	var node_output_slots:Array[MyyVisualShaderNodePort] = []
	for slot_info in parsed_node["inputs"]:
		add_slot(slot_info, node_input_slots)
	for slot_info in parsed_node["outputs"]:
		add_slot(slot_info, node_output_slots)

	en_name = node_name
	en_description = node_description
	en_category = node_category
	node_code_format = node_code
	inputs = node_input_slots
	outputs = node_output_slots
	return true

func load_definition_json(json_data:String) -> bool:

	var json_parser := JSON.new()
	var err_code := json_parser.parse(json_data)
	if err_code != OK:
		return false

	var parsed_node:Dictionary = json_parser.data

	return load_definition_dictionary(parsed_node)

func _get_code(input_values:Array, output_values:Array, _mode:Shader.Mode, _type:VisualShader.Type) -> String:
	var replacements := {}
	for i in range(len(input_values)):
		replacements["i%d"%(i)] = get_input_value(i, input_values)
	
	for o in range(len(output_values)):
		var output_name = output_values[o]
		replacements["o%d"%(o)] = output_name
	var replacement := node_code_format.format(replacements)
	return replacement

func add_slot(slot_definition:Dictionary, slots:Array[MyyVisualShaderNodePort]):
	if not slot_definition.has_all(["name","type"]):
		return
	var slot_name:String = slot_definition["name"]
	var slot_type_text:String = slot_definition["type"]

	if not text_type_to_port_type.has(slot_type_text):
		return

	var slot_type_and_default:Array = text_type_to_port_type[slot_type_text]
	var slot_type:VisualShaderNode.PortType = slot_type_and_default[0]
	var default_value = slot_type_and_default[1]

	slots.append(MyyVisualShaderNodePort.new(
		slot_type,
		slot_name,
		default_value))

func _init() -> void:
	pass

var text_type_to_port_type:Dictionary = {
	"float": [VisualShaderNode.PORT_TYPE_SCALAR, 0.],
	"vec2": [VisualShaderNode.PORT_TYPE_VECTOR_2D, Vector2(0.,0.)],
	"vec3": [VisualShaderNode.PORT_TYPE_VECTOR_3D, Vector3(0.,0.,0.)],
	"vec4": [VisualShaderNode.PORT_TYPE_VECTOR_4D, Vector4(0.,0.,0.,0.)]
}

	

	
	
	
	
	
	
	
