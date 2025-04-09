class_name IdGenerator

var next_id:int = 1

func generate_new_id():
	var ret_id:int = next_id
	next_id += 1
	return ret_id
