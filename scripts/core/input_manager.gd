class_name InputManager
extends Node

signal move_up
signal move_down
signal move_left
signal move_right
signal confirm
signal menu

func _unhandled_input(event):
	if event.is_action_pressed("move_up"):
		emit_signal("move_up")

	elif event.is_action_pressed("move_down"):
		emit_signal("move_down")

	elif event.is_action_pressed("move_left"):
		emit_signal("move_left")

	elif event.is_action_pressed("move_right"):
		emit_signal("move_right")

	elif event.is_action_pressed("confirm"):
		emit_signal("confirm")

	elif event.is_action_pressed("menu"):
		emit_signal("menu")
