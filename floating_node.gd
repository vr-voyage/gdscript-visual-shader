extends Panel

class_name BoardNode

@export var debug_text:Label
@export var node_res:BoardNodeRes
signal board_node_selected(board_node:BoardNodeRes)

var move_origin:Vector2
var moving:bool = false

func p(message:String) -> void:
	if debug_text != null:
		debug_text.text = message

func _on_gui_input(event:InputEvent):
	if event is InputEventScreenTouch:
		var touch = event as InputEventScreenTouch
		if touch == null:
			return

		moving = touch.pressed
		if moving:
			board_node_selected.emit(node_res)
			move_origin = touch.position
			p(str(move_origin))
		else:
			save_position()

	if event is InputEventScreenDrag:
		if !moving:
			return
		var drag = event as InputEventScreenDrag
		position += (drag.position - move_origin)

func display():
	var node_rect:Rect2 = node_res.rect
	position = node_rect.position
	size = node_rect.size

func save_position():
	node_res.rect = Rect2(position,size)
