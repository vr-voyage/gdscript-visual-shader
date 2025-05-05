extends Resource

class_name MyyVisualShaderNodeSignature

@export var inputs:Array[MyyVisualShaderNodePort]
@export var outputs:Array[MyyVisualShaderNodePort]

static func add_slot(signature_definition:Dictionary, slots:Array[MyyVisualShaderNodePort]) -> void:
	if not signature_definition.has_all(["name","type"]):
		printerr("Slot with missing name or type")
		return
	var slot_name:String = signature_definition["name"]
	var slot_type_text:String = signature_definition["type"]

	if not text_type_to_port_type.has(slot_type_text):
		printerr("Slot %s has a weird slot type %s" % [slot_name, slot_type_text])
		return

	var slot_type_and_default:Array = text_type_to_port_type[slot_type_text]
	var slot_type:VisualShaderNode.PortType = slot_type_and_default[0]
	var default_value = slot_type_and_default[1]

	slots.append(MyyVisualShaderNodePort.new(
		slot_type,
		slot_name,
		default_value))
	return

const text_type_to_port_type:Dictionary = {
	"float": [VisualShaderNode.PORT_TYPE_SCALAR, 0.],
	"vec2": [VisualShaderNode.PORT_TYPE_VECTOR_2D, Vector2(0.,0.)],
	"vec3": [VisualShaderNode.PORT_TYPE_VECTOR_3D, Vector3(0.,0.,0.)],
	"vec4": [VisualShaderNode.PORT_TYPE_VECTOR_4D, Vector4(0.,0.,0.,0.)],
	"int": [VisualShaderNode.PORT_TYPE_SCALAR_INT, 0],
	"uint": [VisualShaderNode.PORT_TYPE_SCALAR_UINT, 0],
	"bool": [VisualShaderNode.PORT_TYPE_BOOLEAN, false]
}

const port_types:Dictionary[VisualShaderNode.PortType, String] = {
	VisualShaderNode.PORT_TYPE_SCALAR: "float",
	VisualShaderNode.PORT_TYPE_VECTOR_2D: "vec2",
	VisualShaderNode.PORT_TYPE_VECTOR_3D: "vec3",
	VisualShaderNode.PORT_TYPE_VECTOR_4D: "vec4",
	VisualShaderNode.PORT_TYPE_SCALAR_INT: "int",
	VisualShaderNode.PORT_TYPE_SCALAR_UINT: "uint",
	VisualShaderNode.PORT_TYPE_BOOLEAN: "bool",
	VisualShaderNode.PORT_TYPE_SAMPLER: "sampler2D",
	VisualShaderNode.PORT_TYPE_TRANSFORM: "transform"
}

func _to_string():
	var s:String = "inputs: ["
	for input in inputs:
		s += ("[%s, %s]" % [input.en_name, port_types[input.type]])
	s += "], outputs: ["
	for output in outputs:
		s += ("[%s, %s]" % [output.en_name, port_types[output.type]])
	s+= "]"
	return s

static func load_from_dictionary(dict:Dictionary) -> MyyVisualShaderNodeSignature:
	var new_inputs:Array[MyyVisualShaderNodePort] = []
	var new_outputs:Array[MyyVisualShaderNodePort] = []

	if dict.has("inputs"):
		var add_slot_successful:bool = true
		for slot_info in dict["inputs"]:
			add_slot(slot_info, new_inputs)


	if dict.has("outputs"):
		var add_slot_successful:bool = true
		for slot_info in dict["outputs"]:
			add_slot(slot_info, new_outputs)

	var new_signature := MyyVisualShaderNodeSignature.new()
	new_signature.inputs = new_inputs
	new_signature.outputs = new_outputs
	return new_signature
