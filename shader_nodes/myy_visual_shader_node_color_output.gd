extends MyyVisualShaderNode

class_name MyyVisualShaderNodeOutput

func set_node_info() -> Dictionary:
	id = 0
	return {
		"name": "Fragment output",
		"category": "Hidden",
		"description": "Output node of the fragment node. Always available with the ID 0",
		"inputs": [
			MyyVisualShaderNodePort.new(VisualShaderNode.PORT_TYPE_VECTOR_3D, "albedo", Color.GRAY),
			MyyVisualShaderNodePort.new(VisualShaderNode.PORT_TYPE_SCALAR, "alpha", 1.0),
			MyyVisualShaderNodePort.new(VisualShaderNode.PORT_TYPE_SCALAR, "metallic", 0.0),
			MyyVisualShaderNodePort.new(VisualShaderNode.PORT_TYPE_SCALAR, "roughness", 1.0),
			MyyVisualShaderNodePort.new(VisualShaderNode.PORT_TYPE_SCALAR, "specular", 0.5),
			MyyVisualShaderNodePort.new(VisualShaderNode.PORT_TYPE_VECTOR_3D, "Emission", Color.BLACK)
		],
		"outputs": []}

func get_id() -> int:
	return 0

func set_id(_new_id:int):
	pass

func add_to_shader(_visual_shader:VisualShader, _shader_phase:VisualShader.Type):
	# We lie. The shader is NEVER initialized
	pass
