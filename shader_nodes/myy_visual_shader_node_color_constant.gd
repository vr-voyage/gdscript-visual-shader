extends MyyVisualShaderNode

class_name MyyVisualShaderNodeColorConstant

func set_node_info() -> Dictionary:
	return {
		"name": "Color Constant",
		"category": "Color",
		"description": "A simple color constant",
		"inputs": [],
		"outputs": [
			MyyNodePort.new(VisualShaderNode.PORT_TYPE_VECTOR_3D, "color", Color.BLACK),
			MyyNodePort.new(VisualShaderNode.PORT_TYPE_SCALAR, "alpha", 1.0)
		]
	}

func _get_code(input_values:Array, output_values:Array, mode:Shader.Mode, type:VisualShader.Type) -> String:
	var color_var_name:String = output_values[0] as String
	var alpha_var_name:String = output_values[1] as String
	var color_value:Color = outputs[0].default_value as Color
	return """vec4 color_value = vec4%s;
	%s = color_value.rgb;
	%s = color_value.a;
	""" % [color_value, color_var_name, alpha_var_name]
	
	
	
	
	
