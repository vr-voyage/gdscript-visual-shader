extends MyyVisualShaderGraphNodeSlot

class_name MyyVisualShaderGraphNodeSlotFloat

@export var label:Label
@export var spin_box:SpinBox

func setup_for(port:MyyVisualShaderNode.MyyNodePort):
	label.text = port.en_name.to_pascal_case()
	spin_box.value_changed.connect(
		func (value:float):
			print_debug("Spinboxed !")
			port.default_value = value
			shader_slot_updated.emit()
	)
