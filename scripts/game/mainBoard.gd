class_name MainBoardView
extends GridContainer

var SIZE := 3
var boards: Array = []

func _ready():
	columns = SIZE
	
	for i in range (SIZE*SIZE):
		var board = preload("res://scenes/game/smallBoard.tscn").instance()
		add_child(board)
		boards.append(board)
	
	set_cursor(0, 0)

func update_from_state(state: GameState):
	for i in range(SIZE*SIZE):
		boards[i].update_from_state(state.boards[i])

func update_cell(board_index, cell_index, player):
	boards[board_index].update_cell(
		cell_index,
		player
	)

func set_cursor(board_index: int, cell_index: int):
	for i in range(boards.size()):
		if i == board_index:
			boards[i].set_cursor(cell_index)
		else:
			boards[i].set_cursor(-1)

func finish_board(board_index: int, winner: int):
	print("FINISHED BOARD: ", board_index, " WINNER: ", winner)
	boards[board_index].set_winner(winner)
