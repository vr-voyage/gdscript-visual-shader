extends Button

class_name TypeSelectButton



signal type_selected(type:VisualShaderNode.PortType)

func _ready():
	self.pressed.connect(on_pressed)
	self.toggled.connect(on_toggled)


func on_toggled(state:bool):
	print_debug(state)

func on_pressed():
	print("a")
