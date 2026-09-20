extends GridContainer

var SIZE = 3
var boards = []

signal move_played(board_index, cell_index)


# Called when the node enters the scene tree for the first time.
func _ready():
	columns = SIZE
	
	for i in range (SIZE*SIZE):
		var board = preload("res://scenes/smallBoard.tscn").instance()
		add_child(board)
		boards.append(board)
		
		board.connect("board_played", self, "_on_board_played", [i])
		
func _on_board_played(cell, board_index):
	var cell_index = cell.get_index()
	emit_signal("move_played", board_index, cell_index)


func get_cell(x, y):
	var board_x = int(x / 3)
	var board_y = int(y / 3)
	var board_index = board_y * 3 + board_x
	var board = boards[board_index]
	
	var cell_x = x % 3
	var cell_y = y % 3
	var cell_index = cell_y * 3 + cell_x
	
	return board.cells[cell_index]
