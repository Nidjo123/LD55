extends HSlider


# Called when the node enters the scene tree for the first time.
func _ready():
	var master_bus_idx = AudioServer.get_bus_index("Master")
	var volume_db = AudioServer.get_bus_volume_db(master_bus_idx)
	set_value_no_signal(db_to_linear(volume_db))


func _on_value_changed(value):
	var master_bus_idx = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(master_bus_idx, linear_to_db(value))
