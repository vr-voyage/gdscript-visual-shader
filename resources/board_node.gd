extends Resource

class_name BoardNodeRes

@export var node_id:int
@export var node_type:String
@export var node_name:String
@export var inputs:Array[NodeField]
@export var outputs:Array[NodeField]

@export var rect:Rect2 = Rect2(0,0,200,600)

func _init():
	if inputs.is_empty() and outputs.is_empty():
		var input_a = NodeField.new()
		input_a.field_name = "A"
		input_a.field_type = "String"
	
		var input_b:NodeField = NodeField.new()
		input_b.field_name = "B"
		input_b.field_type = "int"
		inputs = [
			input_a,input_b
		]






