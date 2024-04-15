extends Control


func _ready():
	$VBoxContainer/PlayButton.grab_focus()


func _on_play_button_pressed():
	var music = get_node('/root/MusicTheme')
	music.play()
	get_tree().change_scene_to_file("res://Scenes/Level.tscn")


func _on_exit_button_pressed():
	get_tree().quit()


func _on_about_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/AboutMenu.tscn")
