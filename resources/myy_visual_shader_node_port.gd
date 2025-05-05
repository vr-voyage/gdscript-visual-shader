extends Resource

class_name MyyVisualShaderNodePort

@export var type:VisualShaderNode.PortType
@export var en_name:String = ""
@export var constant:bool = false

var default_value:Variant

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
