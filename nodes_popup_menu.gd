extends PopupMenu

class_name AddNodeMenu

signal add_node_request(node_name:String)

func refresh_using_library(library:SimpleNodesLibrary) -> void:
	clear()
	for method_name in library.retrieve_register_methods():
		add_item(method_name)

func _on_popup_menu_index_pressed(index:int) -> void:
	var node_name:String = get_item_text(index)
	add_node_request.emit(node_name)
	hide()
