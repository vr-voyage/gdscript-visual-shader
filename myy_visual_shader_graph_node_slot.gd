extends Control

class_name MyyVisualShaderGraphNodeSlot

signal shader_slot_updated()

func setup_for(_port:MyyVisualShaderNodePort):
	pass

# Unused method to avoid a warning
func nawak():
	shader_slot_updated.emit()
