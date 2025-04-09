extends VBoxContainer

@export var output:ItemList

func _ready():
	var classes:Array[Dictionary] = ProjectSettings.get_global_class_list()
	for info in classes:
		var classname:String = info["class"]
		if "Myy" in classname:
			output.add_item(classname)
