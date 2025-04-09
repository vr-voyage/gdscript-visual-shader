extends MyyVisualShaderGraphNodeSlot

class_name MyyVisualShaderGraphNodeSlotVector2

@export var label:Label
@export var vector2_setter:SetterControlVector2

func setup_for(port:MyyVisualShaderNode.MyyNodePort):
	label.text = port.en_name.to_pascal_case()
	vector2_setter.value_changed.connect(
		func (new_value:Vector2):
			port.default_value = new_value
			shader_slot_updated.emit()
	)
