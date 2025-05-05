extends GraphNode

class_name MyyVisualShaderGraphNode

var shader_node:MyyVisualShaderNode

signal shader_node_updated(node:MyyVisualShaderGraphNode)

@export var default_slot_setter:PackedScene
var type_setters_prefabs:Dictionary = {
	TYPE_COLOR: preload("res://myy_visual_shader_graph_node_slot_color_select.tscn"),
	TYPE_VECTOR2: preload("res://myy_visual_shader_graph_node_slot_vector2.tscn"),
	TYPE_FLOAT: preload("res://myy_visual_shader_graph_node_slot_float.tscn")
}

class PortSetters:
	var set_type:Callable
	var set_color:Callable
	var set_enabled:Callable

	func _init(type:Callable, color:Callable, enabled:Callable):
		set_type = type
		set_color = color
		set_enabled = enabled

var input_setters:PortSetters = PortSetters.new(
	self.set_slot_type_left,
	self.set_slot_color_left,
	self.set_slot_enabled_left)

var output_setters:PortSetters = PortSetters.new(
	self.set_slot_type_right,
	self.set_slot_color_right,
	self.set_slot_enabled_right)

func display(shader:MyyVisualShaderNode):
	shader_node = shader
	set_title(shader.en_name)
	setup_port_slots(shader.get_inputs(), input_setters)
	setup_port_slots(shader.get_outputs(), output_setters)

func _on_slot_updated():
	shader_node.emit_changed()
	shader_node_updated.emit(self)

func add_port_display(port:MyyVisualShaderNodePort):
	var default_value_type:int = typeof(port.default_value)
	var slot_setter_prefab:PackedScene = default_slot_setter
	if default_value_type in type_setters_prefabs:
		slot_setter_prefab = type_setters_prefabs[default_value_type]
	var slot_setter:MyyVisualShaderGraphNodeSlot = slot_setter_prefab.instantiate()
	add_child(slot_setter)
	slot_setter.setup_for(port)
	slot_setter.shader_slot_updated.connect(_on_slot_updated)

func setup_port_slot(port:MyyVisualShaderNodePort, setters:PortSetters):
	if port.constant:
		return
	var index:int = get_child_count()
	add_port_display(port)
	setters.set_enabled.call(index, true)
	setters.set_color.call(index, Color.AQUA)
	setters.set_type.call(index, port.type)

func setup_port_slots(ports:Array[MyyVisualShaderNodePort], setters:PortSetters):
	for port in ports:
		setup_port_slot(port, setters)
		
		
		
		
		
		
		
		
		
		
		
