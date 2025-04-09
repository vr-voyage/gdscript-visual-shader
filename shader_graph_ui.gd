extends Control

@export var graph_edit:GraphEdit
@export var library:Node
@export var nodes_menu:AddNodeMenu

var stop_moving:bool = false

func _input(event):
	if stop_moving:
		return
	if event is InputEventScreenDrag:
		var touch_event:InputEventScreenDrag = event
		graph_edit.scroll_offset -= touch_event.relative
		graph_edit.get_menu_hbox()
		
func disable_movements():
	stop_moving = true

func enable_movements():
	stop_moving = false

func connection_drag_started(_a,_b,_c):
	disable_movements()

func connection_drag_ended(_a,_b,_c):
	enable_movements()

func _library_reloaded(nodes_library:SimpleNodesLibrary):
	nodes_menu.refresh_using_library(nodes_library)

func _add_node_name(node_name:String):
	var nodes_library:SimpleNodesLibrary = library.get_library()
	graph_edit.add_shader_node_to_graph(nodes_library.retrieve_default_for_method(node_name))
