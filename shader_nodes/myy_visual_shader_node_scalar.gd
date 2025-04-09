extends MyyVisualShaderNode

class_name MyyVisualShaderNodeScalar

func set_node_info() -> Dictionary:
	return {
		"name": "Scalar Constant",
		"category": "Constant",
		"description": "A simple constant",
		"inputs": [],
		"outputs": [
			MyyNodePort.new(VisualShaderNode.PORT_TYPE_SCALAR, "value", 1.),
		]
	}

func _get_code(input_values:Array, output_values:Array, mode:Shader.Mode, type:VisualShader.Type) -> String:
	var var_name:String = output_values[0] as String
	return """%s = %s;""" % [var_name, get_outputs()[0].default_value]

	
	
	
	
