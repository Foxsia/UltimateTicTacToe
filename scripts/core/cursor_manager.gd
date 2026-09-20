class_name CursorManager
extends Node

signal cursor_changed(board_index, cell_index)

var board_index := 0
var cell_index := 0

var game_manager: GameManager

func _ready():
	emit_signal("cursor_changed", board_index, cell_index)

func move(direction: Vector2):
	var x = cell_index % 3
	var y = int(cell_index / 3)

	x += direction.x
	y += direction.y

	x = clamp(x, 0, 2)
	y = clamp(y, 0, 2)

	cell_index = y * 3 + x
	emit_signal("cursor_changed", board_index, cell_index)

func update_board():
	if game_manager.state.forced_board != -1:
		board_index = game_manager.state.forced_board
		cell_index = 0
	
	emit_signal("cursor_changed", board_index, cell_index)
