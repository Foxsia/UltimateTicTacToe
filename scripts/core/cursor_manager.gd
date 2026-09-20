class_name CursorManager
extends Node

var board_index := 0
var cell_index := 0

var game_manager: GameManager

func move(direction: Vector2):
	var x = cell_index % 3
	var y = int(cell_index / 3)

	x += direction.x
	y += direction.y

	x = clamp(x, 0, 2)
	y = clamp(y, 0, 2)

	cell_index = y * 3 + x
