extends Button

class_name TypeSelectButton

var typeinfo:TypeSelectMenu.TypeInfo = null

signal type_selected(type:VisualShaderNode.PortType)

func _ready():
	self.pressed.connect(on_pressed)
	self.toggled.connect(on_toggled)

func set_with(new_typeinfo:TypeSelectMenu.TypeInfo):
	self.text = new_typeinfo.name
	self.typeinfo = new_typeinfo

func on_toggled(state:bool):
	print_debug(state)

func on_pressed():
	print("a")
	if typeinfo == null: return
	type_selected.emit(typeinfo.type)
