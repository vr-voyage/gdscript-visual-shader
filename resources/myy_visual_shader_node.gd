extends VisualShaderNodeCustom

class_name MyyVisualShaderNode



class MyyNodePort:
	var type:VisualShaderNode.PortType
	var default_value
	var en_name:String = ""
	var constant:bool = false
	
	func _init(
		param_type:VisualShaderNode.PortType,
		param_name:String,
		param_value,
		is_constant=false):
		
		type = param_type
		en_name = param_name
		default_value = param_value
		constant = is_constant

	func value_to_shader() -> String:
		var shader_code:String = ""
		match(typeof(default_value)):
			TYPE_COLOR, TYPE_VECTOR4:
				shader_code = "vec4(%f,%f,%f,%f)" % [default_value[0],default_value[1],default_value[2],default_value[3]]
			TYPE_VECTOR3:
				shader_code = "vec3(%f,%f,%f)" % [default_value[0],default_value[1],default_value[2]]
			TYPE_VECTOR2:
				shader_code = "vec2(%f,%f)" % [default_value[0],default_value[1]]
			TYPE_FLOAT:
				shader_code = str(default_value)
				if not "." in shader_code:
					shader_code += "."
			TYPE_INT:
				shader_code = str(default_value)
			TYPE_STRING:
				shader_code = default_value
			_:
				shader_code = ""
		return shader_code

var en_name:String
var en_description:String
var en_category:String
var inputs:Array[MyyNodePort] = []
var outputs:Array[MyyNodePort] = []
var node_code_format:String
var id:int

func get_outputs() -> Array[MyyNodePort]:
	return outputs

func get_inputs() -> Array[MyyNodePort]:
	return inputs

func _get_input_port_count() -> int:
	return len(inputs)
	
func _get_input_port_default_value(port) -> int:
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



func get_value_or_default(index:int, values:Array, slots:Array[MyyNodePort]) -> String:
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
