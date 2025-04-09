extends Control

@export var grid:GridContainer
@export var button_template:PackedScene

class PortTypeInfo:
	var name:String
	var icon:Texture2D
	func _init(new_name:String, new_icon:Texture2D = null):
		name = new_name
		icon = new_icon

var port_types_representations:Dictionary = {
	VisualShaderNode.PORT_TYPE_SCALAR: PortTypeInfo.new("scalar"),
	VisualShaderNode.PORT_TYPE_VECTOR_2D: PortTypeInfo.new("vec2"),
	VisualShaderNode.PORT_TYPE_VECTOR_3D: PortTypeInfo.new("vec3"),
	VisualShaderNode.PORT_TYPE_VECTOR_4D: PortTypeInfo.new("vec4"),
	VisualShaderNode.PORT_TYPE_SCALAR_INT: PortTypeInfo.new("int"),
	VisualShaderNode.PORT_TYPE_SCALAR_UINT: PortTypeInfo.new("uint"),
	VisualShaderNode.PORT_TYPE_SAMPLER: PortTypeInfo.new("sampler"),
	VisualShaderNode.PORT_TYPE_BOOLEAN: PortTypeInfo.new("bool"),
	VisualShaderNode.PORT_TYPE_TRANSFORM: PortTypeInfo.new("mat4")
}

signal port_type_selected(port_type:PortTypeInfo)

func _ready() -> void:
	for port_type in port_types_representations:
		var new_button:Button = button_template.instantiate()
		var representation:PortTypeInfo = port_types_representations[port_type]
		new_button.text = representation.name
		new_button.pressed.connect(
			func(): port_type_selected.emit(port_type)
		)
		grid.add_child(new_button)
