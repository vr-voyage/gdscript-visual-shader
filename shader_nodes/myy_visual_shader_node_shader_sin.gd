extends MyyVisualShaderNode

class_name MyyVisualShaderNodeSin

func set_node_info() -> Dictionary:
	return {
		"name": "Sin",
		"category": "Shader",
		"description": "The sin function",
		"inputs": [
			MyyNodePort.new(VisualShaderNode.PORT_TYPE_SCALAR, "angle", 0.),
		],
		"outputs": [
			MyyNodePort.new(VisualShaderNode.PORT_TYPE_SCALAR, "result", null)
		]
	}

func _get_code(input_values:Array, output_values:Array, mode:Shader.Mode, type:VisualShader.Type) -> String:
	var theta:String = get_input_value(0,input_values)
	var output_name:String = output_values[0]
	return """%s = sin(%s);""" % [output_name, theta]
	
	
	
	
	
