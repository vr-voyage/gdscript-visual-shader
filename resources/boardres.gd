extends Resource

class_name BoardRes

@export var board_name:String
@export var board_nodes:Array[BoardNodeRes]

func create_node():
	var node:BoardNodeRes = BoardNodeRes.new()
	board_nodes.append(node)
