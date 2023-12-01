extends Node
# Put in Autoload to use

var __data_store := {}
signal on_data_changed(key, new_data, old_data)

func get_data(key: String):
	return __data_store.get(key)

func set_data(key: String, data):
	var old_data = __data_store.get(key)
	if old_data == data: return
	__data_store[key] = data
	on_data_changed.emit(key, data, old_data)
	return __data_store[key]
