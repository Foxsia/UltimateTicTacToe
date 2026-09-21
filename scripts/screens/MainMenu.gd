extends Control

func _on_play_button_pressed():
	get_tree().change_scene("res://scenes/game/game.tscn")


func _on_exit_button_pressed():
	get_tree().quit()

func _ready():
	$PlayButton.grab_focus()
	$PlayButton.connect("focus_entered", self, "_on_play_focus_entered")
	$PlayButton.connect("focus_exited", self, "_on_play_focus_exited")
	
	$ExitButton.connect("focus_entered", self, "_on_exit_focus_entered")
	$ExitButton.connect("focus_exited", self, "_on_exit_focus_exited")


func _on_play_focus_entered():
	$PlayButton/FocusLine.show()


func _on_play_focus_exited():
	$PlayButton/FocusLine.hide()

func _on_exit_focus_entered():
	$ExitButton/FocusLine.show()


func _on_exit_focus_exited():
	$ExitButton/FocusLine.hide()
