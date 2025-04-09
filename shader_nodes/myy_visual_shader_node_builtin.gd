extends MyyVisualShaderNode

class_name MyyVisualShaderNodeBuiltinTime

func set_node_info() -> Dictionary:
	return {
		"name": "Builtin",
		"category": "Builtin",
		"description": "Built-in Time",
		"inputs": [],
		"outputs": [
			MyyNodePort.new(VisualShaderNode.PORT_TYPE_SCALAR, "time", null)
		]
	}

func _get_code(_input_values:Array, output_values:Array, _mode:Shader.Mode, _type:VisualShader.Type) -> String:
	var out_var_name:String = output_values[0] as String
	return """%s = TIME;""" % [out_var_name]
	
	
	
	
	
