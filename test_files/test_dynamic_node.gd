extends Control

@export var ui_debug_output:Label

var test_file_path := "res://test_files/ACos.json"

func p(value):
	if ui_debug_output != null:
		ui_debug_output.text += str(value) + "\n"

func _ready():
	var test_file_content := FileAccess.get_file_as_string(test_file_path)
	if test_file_content == null:
		p("Can't open file")
	else:
		p(test_file_content)

	var visual_node := MyyVisualShaderDynamicNode.new()
	visual_node.load_definition_json(test_file_content)
	p(visual_node.inputs)
	p(visual_node.outputs)
	return

	var json_parser := JSON.new()
	var err_code := json_parser.parse(test_file_content)
	if err_code != OK:
		p(json_parser.get_error_message())
		return
	var parsed_node:Dictionary = json_parser.data
	p(parsed_node)

	if not parsed_node.has_all(["name", "inputs", "outputs","code"]):
		return

	p("ok")
	var node_name:String = parsed_node["name"]
	var node_code:String = parsed_node["code"]

	var input_slots:Array[MyyVisualShaderNodePort] = []
	var output_slots:Array[MyyVisualShaderNodePort] = []
	for slot_info in parsed_node["inputs"]:
		add_slot(slot_info, input_slots)
	for slot_info in parsed_node["outputs"]:
		add_slot(slot_info, output_slots)

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

var text_type_to_port_type:Dictionary = {
	"float": [VisualShaderNode.PORT_TYPE_SCALAR, 0.],
	"vec2": [VisualShaderNode.PORT_TYPE_VECTOR_2D, Vector2(0.,0.)],
	"vec3": [VisualShaderNode.PORT_TYPE_VECTOR_3D, Vector3(0.,0.,0.)],
	"vec4": [VisualShaderNode.PORT_TYPE_VECTOR_4D, Vector4(0.,0.,0.,0.)]
}
