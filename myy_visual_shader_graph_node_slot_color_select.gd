extends MyyVisualShaderGraphNodeSlot

class_name MyyVisualShaderGraphNodeSlotColorSelect

@export var label:Label
@export var color_picker:ColorPickerButton

func setup_for(port:MyyVisualShaderNode.MyyNodePort):
	label.text = port.en_name.to_pascal_case()
	color_picker.color_changed.connect(
		func (color:Color):
			port.default_value = color
			shader_slot_updated.emit()
	)
