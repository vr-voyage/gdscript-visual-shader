extends VBoxContainer


@export var list_title:String :
	get():
		return list_title
	set(v):
		list_title = v
		if title_label != null:
			title_label.text = v

@export var color:Color :
	get():
		return color
	set(v):
		color = v
		if color_rect != null:
			color_rect.color = v


var displayed_list:Array :
	set(v):
		if items_list != null:
			items_list.clear()
			for item in v:
				items_list.add_item(str(item))

signal add_item_request(item_name:String)
signal item_selected(item_index:int)

@export_category("UI")
@export var color_rect:ColorRect
@export var title_label:Label
@export var items_list:ItemList
@export var add_item_button:Button
@export var new_item_edit:LineEdit

func _ready() -> void:
	color = color
	list_title = list_title


func _on_item_list_item_selected(index: int) -> void:
	item_selected.emit(index)
	pass # Replace with funct
