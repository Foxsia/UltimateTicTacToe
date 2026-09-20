class_name CellView
extends Control

onready var texture_rect = $TextureRect

func set_player(player: int):
	match player:
		GameState.Player.RASPBERRY:
			texture_rect.texture = preload(
				"res://assets/textures/raspberry.png"
			)

		GameState.Player.BLUEBERRY:
			texture_rect.texture = preload(
				"res://assets/textures/blueberry.png"
			)

		GameState.Player.NONE:
			texture_rect.texture = null

func set_highlight(active: bool):
	if active:
		modulate = Color(1.0, 1.0, 0.5)
	else:
		modulate = Color.white
