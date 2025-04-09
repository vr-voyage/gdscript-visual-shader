extends PanelContainer

class_name NodeInfoPanel

@export var debug_text:Label
@export var slide_time:float = 0.25
@export var inputs_list:ItemList
@export var outputs_list:ItemList

func parent_dimensions() -> Vector2:
	return get_viewport_rect().size

func p(text:String):
	if debug_text != null:
		debug_text.text += text 

func move(n_pixels:float):
	var current_parent_dimensions:Vector2 = parent_dimensions()
	var tween = get_tree().create_tween()
	var vec = position
	vec.x = current_parent_dimensions.x - n_pixels
	tween.tween_property(self, "position", vec, slide_time)

func slide_out():
	move(0)

func slide_in():
	move(size.x)

func _ready():
	var dimensions = get_viewport_rect().size
	size.y = dimensions.y
	position.x = dimensions.x

func after(seconds: float, action: Callable):
	get_tree().create_timer(seconds).timeout.connect(action)

func show_fields_in(items_list:ItemList, fields:Array[NodeField]):
	items_list.clear()
	for field in fields:
		items_list.add_item(field.field_name)

func display_node(board_node_res:BoardNodeRes):
	show_fields_in(inputs_list, board_node_res.inputs)
	show_fields_in(outputs_list, board_node_res.outputs)
	pass






