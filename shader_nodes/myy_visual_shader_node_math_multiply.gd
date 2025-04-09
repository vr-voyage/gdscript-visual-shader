extends MyyVisualShaderNode

class_name MyyVisualShaderNodeMultiply

func set_node_info() -> Dictionary:
	return {
		"name": "Multiply",
		"category": "Math",
		"description": "Multiply",
		"inputs": [
			MyyNodePort.new(VisualShaderNode.PORT_TYPE_SCALAR, "x", 1.),
			MyyNodePort.new(VisualShaderNode.PORT_TYPE_SCALAR, "y", 1.)
		],
		"outputs": [
			MyyNodePort.new(VisualShaderNode.PORT_TYPE_SCALAR, "result", null)
		]
	}

func _get_code(input_values:Array, output_values:Array, mode:Shader.Mode, type:VisualShader.Type) -> String:
	var x:String = get_input_value(0,input_values)
	var y:String = get_input_value(1,input_values)
	var output_name:String = output_values[0]
	return """%s = %s * %s;""" % [output_name, x, y]
	
	
	
	
	
