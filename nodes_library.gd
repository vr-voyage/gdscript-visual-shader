extends Node

@export var library:SimpleNodesLibrary
@export_dir var library_path:String

signal library_reloaded(library:SimpleNodesLibrary)

func get_library() -> SimpleNodesLibrary:
	return library

func _ready():
	if library == null:
		library = SimpleNodesLibrary.new()
	library.load_json_libraries_from_directory(library_path)
	library_reloaded.emit(library)

func p(message:String) -> void:
	printerr(message)
	return

func provide_node(method_name:String) -> MyyVisualShaderDynamicNode:
	var ret_node:MyyVisualShaderDynamicNode = library.retrieve_default_node_for(method_name)
	if ret_node == null:
		p("Could not retrieve node for method %s" % method_name)
	return ret_node
