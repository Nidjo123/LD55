extends Control


func _ready():
	var music_node = $"/root/MusicTheme"
	music_node.stream = load("res://Art/Audio/menu_theme.wav")
	music_node.play()
	$VBoxContainer/PlayButton.grab_focus()


func _on_play_button_pressed():
	var music = get_node('/root/MusicTheme')
	music.stream = load("res://Art/Audio/theme.wav")
	music.play()
	get_tree().change_scene_to_file("res://Scenes/Level.tscn")


func _on_exit_button_pressed():
	get_tree().quit()


func _on_about_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/AboutMenu.tscn")
