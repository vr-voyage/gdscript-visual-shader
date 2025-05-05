extends Resource

class_name SimpleNodesLibrary

@export var items:Dictionary[String,MyyVisualShaderNodeFactory]

func retrieve_register_methods() -> PackedStringArray:
	return items.keys()

func add_item(factory:MyyVisualShaderNodeFactory) -> bool:
	var key:String = factory.en_name
	if items.has(key):
		items[key].combine_with(factory)
	else:
		items[key] = factory
	return true

func has_item(item_name:String) -> bool:
	return items.has(item_name)

func get_factory(item_name:String) -> MyyVisualShaderNodeFactory:
	if has_item(item_name):
		return items[item_name]
	return null

func retrieve_default_for_method(key:String) -> MyyVisualShaderNode:
	if not items.has(key):
		return null
	return items[key].instantiate_node()

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
		
		var node := MyyVisualShaderNodeFactory.load_definition_dictionary(dict_definition)
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
