extends MyyVisualShaderNode

class_name MyyVisualShaderNodeUiComposeVector3

func set_node_info() -> Dictionary:
	return {
		"name": "Compose Vector3 (XYZ)",
		"category": "Shader",
		"description": "Create a Vector3 by assembling the X, Y, Z fields separately",
		"inputs": [
			MyyVisualShaderNodePort.new(VisualShaderNode.PORT_TYPE_SCALAR, "x", 0.),
			MyyVisualShaderNodePort.new(VisualShaderNode.PORT_TYPE_SCALAR, "y", 0.),
			MyyVisualShaderNodePort.new(VisualShaderNode.PORT_TYPE_SCALAR, "z", 0.)
		],
		"outputs": [
			MyyVisualShaderNodePort.new(VisualShaderNode.PORT_TYPE_VECTOR_3D, "result", null)
		]
	}

func _get_code(input_values:Array, output_values:Array, mode:Shader.Mode, type:VisualShader.Type) -> String:
	var x:String = get_input_value(0,input_values)
	var y:String = get_input_value(1,input_values)
	var z:String = get_input_value(2,input_values)
	var output_name:String = output_values[0]
	return """%s = vec3(%s,%s,%s);""" % [output_name, x, y, z]
	
	
	
	
	
