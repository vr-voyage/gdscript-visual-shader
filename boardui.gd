extends PanelContainer

@export var board:Board
@export var load_dialog:FileDialog
@export var save_dialog:FileDialog

func _order_create_node():
	board.add_node()

func _on_load_button_pressed():
	load_dialog.popup_centered_ratio(0.9)

func _on_file_to_load_selected(filepath:String):
	board.load_board(filepath)

func _on_save_button_pressed():
	save_dialog.popup_centered_ratio(0.9)

func _on_save_file_selected(filepath:String):
	board.save_board(filepath)

func _on_add_node_button_pressed():
	_order_create_node()
