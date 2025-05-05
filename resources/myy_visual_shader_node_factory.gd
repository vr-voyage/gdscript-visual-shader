extends Resource

class_name MyyVisualShaderNodeFactory

@export var en_name:String = ""
@export var en_description:String = ""
@export var en_category:String = ""
@export var main_code:String = ""
@export var signatures:Array[MyyVisualShaderNodeSignature] = []

func is_similar_factory(other_factory:MyyVisualShaderNodeFactory) -> bool:
	return (
		en_name == other_factory.en_name &&
		en_description == other_factory.en_description &&
		en_category == other_factory.en_category
	)

func combine_with(other_factory:MyyVisualShaderNodeFactory) -> bool:
	if not is_similar_factory(other_factory):
		return false

	signatures.append_array(other_factory.signatures)
	return true

func get_signature(signature_index:int) -> MyyVisualShaderNodeSignature:
	var n_signatures:int = len(signatures)
	if signature_index >= len(signatures):
		print_debug("Trying to get signature [%d] but only %d signatures available" % [signature_index, n_signatures])
		return null
	return signatures[signature_index]

func instantiate_node(signature_index:int = 0) -> MyyVisualShaderNode:

	var signature := get_signature(signature_index)
	if signature == null:
		return null

	var new_node := MyyVisualShaderDynamicNode.new()
	new_node.en_name = en_name
	new_node.en_description = en_description
	new_node.en_category = en_category
	new_node.node_code_format = main_code
	new_node.inputs = signature.inputs
	new_node.outputs = signature.outputs
	return new_node

func swap_node_signature(node:MyyVisualShaderNode, signature_index:int = 0) -> bool:
	if node.en_name != en_name:
		print_debug("Trying to swap %s node signature using %s factory" % [node.en_name, en_name])
		return false

	var signature := get_signature(signature_index)
	if signature == null:
		return false

	node.inputs = signature.inputs
	node.outputs = signature.outputs

	return true


func has_slot_with(slots:Array[MyyVisualShaderNodePort], slot_index:int, desired_type:VisualShaderNode.PortType) -> bool:
	for slot in slots:
		if slot.type == desired_type:
			return true
	return false

func has_signature_input_with(port_index:int, desired_type:VisualShaderNode.PortType) -> bool:
	for signature in signatures:
		if has_slot_with(signature.inputs, port_index, desired_type):
			return true
	return false

func has_signature_output_with(port_index:int, desired_type:VisualShaderNode.PortType) -> bool:
	for signature in signatures:
		if has_slot_with(signature.outputs, port_index, desired_type):
			return true
	return false

static func load_definition_dictionary(parsed_node:Dictionary) -> MyyVisualShaderNodeFactory:
	if not parsed_node.has_all(["name", "category", "description", "inputs", "outputs","code"]):
		printerr("Missing a required key !")
		return null

	var signature := MyyVisualShaderNodeSignature.load_from_dictionary(parsed_node)
	if signature == null:
		printerr("Could not load signatures")
		return null

	var node_name:String = parsed_node["name"]
	var node_code:String = parsed_node["code"]
	var node_description:String = parsed_node["description"]
	var node_category:String = parsed_node["category"]

	var new_factory := MyyVisualShaderNodeFactory.new()
	new_factory.signatures.append(signature)
	new_factory.en_name = node_name
	new_factory.en_description = node_description
	new_factory.en_category = node_category
	new_factory.main_code = node_code

	return new_factory
