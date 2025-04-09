extends MyyVisualShaderNode

class_name MyyVisualShaderNodeStep

func set_node_info() -> Dictionary:
	return {
		"name": "Step",
		"category": "Shader",
		"description": "The step function",
		"inputs": [
			MyyNodePort.new(VisualShaderNode.PORT_TYPE_VECTOR_2D, "x", Vector2()),
			MyyNodePort.new(VisualShaderNode.PORT_TYPE_VECTOR_2D, "y", Vector2())
		],
		"outputs": [
			MyyNodePort.new(VisualShaderNode.PORT_TYPE_VECTOR_2D, "result", null)
		]
	}

func _get_code(input_values:Array, output_values:Array, mode:Shader.Mode, type:VisualShader.Type) -> String:
	var x:String = get_input_value(0,input_values)
	var y:String = get_input_value(1,input_values)
	var output_name:String = output_values[0]
	return """%s = step(%s,%s);""" % [output_name, x, y]
	
	
	
	
	
