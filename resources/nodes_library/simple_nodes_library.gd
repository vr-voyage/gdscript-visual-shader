extends Resource

class_name SimpleNodesLibrary

@export var items:Dictionary

func retrieve_register_methods() -> PackedStringArray:
	return items.keys()

func _ensure_method_name_exists_in(menu:Dictionary, method_name:String):
	if menu.has(method_name):
		return
	var myy_array:Array[MyyVisualShaderDynamicNode] = []
	menu[method_name] = {"variants": myy_array}

func add_item(shader_node:MyyVisualShaderDynamicNode) -> bool:
	var method_name:String = shader_node.en_name
	_ensure_method_name_exists_in(items, method_name)
	items[method_name]["variants"].append(shader_node)
	return true

func retrieve_default_for_method(method_name:String) -> MyyVisualShaderNode:
	if not items.has(method_name):
		return null
	var nodes:Array[MyyVisualShaderDynamicNode] = items[method_name]["variants"]
	if nodes.is_empty():
		return null
	return nodes[0]

func load_json_library(json_file_content:String) -> bool:
	var json_parser := JSON.new()
	var ret := json_parser.parse(json_file_content)
	if ret != OK:
		return false
	var json_data = json_parser.data
	if not json_data is Dictionary:
		printerr("Invalid library, expected a Dictionary, got something else")
		return false
	
	var potential_library:Dictionary = json_data as Dictionary
	if not potential_library.has_all(["@type", "version", "definitions"]):
		printerr("Library is missing required keys ! (@type, version, definitions)")
		return false

	if potential_library["@type"] != "VoyageSimpleNodesLibrary":
		printerr("Wrong type")
		return false

	var definitions:Array = potential_library["definitions"]
	if definitions == null:
		printerr("The definitions are not an array")
		return false

	for definition in definitions:
		var dict_definition = definition as Dictionary
		if dict_definition == null:
			printerr("Could not retrieve the definition as a Dictionary")
			continue
		
		var node := MyyVisualShaderDynamicNode.from_dictionary(dict_definition)
		if node == null:
			printerr("Could not load the node definition")
			continue
		add_item(node)
	return true

func load_json_libraries_from_directory(dirpath:String) -> bool:
	var dir := DirAccess.open(dirpath)
	if dir == null:
		printerr("Could not open folder")
		return false
	dir.list_dir_begin()
	for file: String in dir.get_files():
		if !file.get_extension().to_lower() == "json":
			continue
		var complete_path:String = dirpath + '/' + file
		var json_file_content := FileAccess.get_file_as_string(complete_path)
		if json_file_content == null:
			printerr("[SimpleNodesLibrary] Can't get content from %s" % complete_path)
			continue

		load_json_library(json_file_content)
	return true
