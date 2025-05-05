extends MyyVisualShaderGraphNodeSlot

class_name MyyVisualShaderGraphNodeSlotNameOnly

@export var label:Label

func setup_for(port:MyyVisualShaderNodePort):
	label.text = port.en_name.to_pascal_case()

