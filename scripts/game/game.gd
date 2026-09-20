extends Control

onready var game_manager = $GameManager
onready var input_manager = $InputManager
onready var cursor_manager = $CursorManager
onready var main_board = $CenterMainBoard/MainBoard

func _ready():
	game_manager.connect("move_played", self, "_on_move_played")
	game_manager.connect("state_changed", self, "_on_state_changed")
	
	input_manager.connect("confirm", self, "_on_confirm")
	
	_on_state_changed()

func _on_confirm():
	var board_index = cursor_manager.board_index
	var cell_index = cursor_manager.cell_index
	
	game_manager.play_move(
		board_index,
		cell_index
	)

func _on_state_changed():
	main_board.update_from_state(game_manager.state)

func _on_move_played(board_index, cell_index, player):
	main_board.update_cell(
		board_index,
		cell_index,
		player
	)
