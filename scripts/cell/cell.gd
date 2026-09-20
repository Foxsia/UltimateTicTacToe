class_name CellView
extends Control

onready var texture_rect = $TextureRect
onready var color_rect = $ColorRect

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
		color_rect.color = Color(1.0, 1.0, 0.0, 0.5)
	else:
		color_rect.color = Color(1.0, 1.0, 1.0, 0.0)
