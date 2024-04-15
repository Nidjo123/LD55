extends Control


func _ready():
	$BeginButton.grab_focus()


func _on_begin_button_pressed():
	var music = get_node('/root/MusicTheme')
	music.stream = load("res://Art/Audio/theme.wav")
	music.play()
	get_tree().change_scene_to_file("res://Scenes/Level.tscn")
