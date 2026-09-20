extends Control

onready var game_manager = $GameManager
onready var input_manager = $InputManager
onready var cursor_manager = $CursorManager
onready var main_board = $mainBoard/GridContainer

func _ready():
	cursor_manager.game_manager = game_manager
	game_manager.connect("move_played", self, "_on_move_played")
	game_manager.connect("state_changed", self, "_on_state_changed")
	game_manager.connect(
		"board_finished",
		main_board,
		"finish_board"
	)
	
	input_manager.connect("confirm", self, "_on_confirm")
	
	input_manager.connect("move_up", self, "_on_move_up")
	input_manager.connect("move_down", self, "_on_move_down")
	input_manager.connect("move_left", self, "_on_move_left")
	input_manager.connect("move_right", self, "_on_move_right")

	cursor_manager.connect(
		"cursor_changed",
		main_board,
		"set_cursor"
	)
	
	_on_state_changed()

func _on_confirm():
	var board_index = cursor_manager.board_index
	var cell_index = cursor_manager.cell_index
	
	game_manager.play_move(
		board_index,
		cell_index
	)
	
	cursor_manager.update_board()

func _on_state_changed():
	main_board.update_from_state(game_manager.state)

func _on_move_played(board_index, cell_index, player):
	main_board.update_cell(
		board_index,
		cell_index,
		player
	)

func _on_move_up():
	cursor_manager.move(Vector2.UP)

func _on_move_down():
	cursor_manager.move(Vector2.DOWN)

func _on_move_left():
	cursor_manager.move(Vector2.LEFT)

func _on_move_right():
	cursor_manager.move(Vector2.RIGHT)
