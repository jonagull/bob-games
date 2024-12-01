extends Control

func _ready():
	$Game1Button.connect("pressed", Callable(self, "_on_game1_button_pressed"))
	$Game2Button.connect("pressed", Callable(self, "_on_game2_button_pressed"))
	$QuitButton.connect("pressed", Callable(self, "_on_quit_button_pressed"))

func _on_game1_button_pressed():
	get_tree().change_scene_to_file("res://scenes/armbar/armbar.tscn")

func _on_game2_button_pressed():
	get_tree().change_scene_to_file("res://scenes/gunfight/gunfight.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
