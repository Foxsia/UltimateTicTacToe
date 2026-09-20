class_name CursorManager
extends Node

const SIZE = 3
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

	if game_manager.state.forced_board == -1:
		if x < 0:
			if board_index % 3 > 0:
				board_index -= 1
				x = 2
		elif x > 2:
			if board_index % 3 < 2:
				board_index += 1
				x = 0
		if y < 0:
			if board_index / 3 > 0:
				board_index -= 3
				y = 2
		elif y > 2:
			if board_index / 3 < 2:
				board_index += 3
				y = 0
	else:
		x = clamp(x, 0, 2)
		y = clamp(y, 0, 2)


	cell_index = y * 3 + x
	emit_signal("cursor_changed", board_index, cell_index)

func update_board():
	if game_manager.state.forced_board != -1:
		board_index = game_manager.state.forced_board
		cell_index = 0
	else:
		for i in range(SIZE*SIZE):
			if game_manager.state.board_status[i] == GameState.BoardStatus.PLAYING:
				board_index = i
				cell_index = 0
				break
	
	emit_signal("cursor_changed", board_index, cell_index)
