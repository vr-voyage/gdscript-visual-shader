extends VisualShaderNodeCustom

class_name MyyVisualShaderNode

var en_name:String
var en_description:String
var en_category:String
var inputs:Array[MyyVisualShaderNodePort] = []
var outputs:Array[MyyVisualShaderNodePort] = []
var node_code_format:String
var id:int

func get_outputs() -> Array[MyyVisualShaderNodePort]:
	return outputs

func get_inputs() -> Array[MyyVisualShaderNodePort]:
	return inputs

func _get_input_port_count() -> int:
	return len(inputs)
	
func _get_input_port_default_value(port) -> Variant:
	return inputs[port].default_value

func _get_input_port_name(port) -> String:
	return inputs[port].en_name

func _get_input_port_type(port) -> int:
	return inputs[port].type
	
func _get_output_port_count() -> int:
	return len(outputs)
	
func _get_output_port_name(port) -> String:
	return outputs[port].en_name
	
func _get_output_port_type(port) -> int:
	return outputs[port].type

func _get_category() -> String:
	return en_category
	
func _get_name() -> String:
	return en_name

func _get_description() -> String:
	return en_description

func set_node_info() -> Dictionary:
	return {
		"name": "",
		"category": "",
		"description": "",
		"inputs": [],
		"outputs": []}

func _init(param_id:int = -1):
	var dev_description:Dictionary = set_node_info()
	en_name = dev_description["name"]
	en_category = dev_description["category"]
	en_description = dev_description["description"]
	inputs.append_array(dev_description["inputs"])
	outputs.append_array(dev_description["outputs"])
	set_id(param_id)

func set_id(param_id:int):
	id = param_id

func get_id() -> int:
	return id



func get_value_or_default(index:int, values:Array, slots:Array[MyyVisualShaderNodePort]) -> String:
	if len(values) > index:
		var ret:String = values[index]
		if ret:
			return ret

	if len(slots) > index:
		return slots[index].value_to_shader()
	return ""

func get_input_value(index:int, values:Array = []) -> String:
	return get_value_or_default(index, values, get_inputs())

func get_output_value(index:int, values:Array = []) -> String:
	return get_value_or_default(index, values, get_outputs())
