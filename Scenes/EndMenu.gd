extends Control


@export var music_stream: AudioStream


func _ready():
	var music_node = get_node("/root/MusicTheme")
	music_node.stream = music_stream
	music_node.play()
	


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
