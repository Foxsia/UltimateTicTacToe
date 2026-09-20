class_name GameState
extends Reference

const SIZE := 9

enum Player { NONE, RASPBERRY, BLUEBERRY }

enum BoardStatus { PLAYING, RASPBERRY_WON, BLUEBERRY_WON, DRAW }

var current_player: int = Player.RASPBERRY
var forced_board: int = -1

var boards: Array = []
var board_status: Array = []

var game_over := false
var winner: int = Player.NONE

func _init():
	reset()

func reset():
	current_player = Player.RASPBERRY
	forced_board = -1
	game_over = false
	winner = Player.NONE
	
	boards.clear()
	board_status.clear()
	
	for board_index in range(SIZE):
		var cells := []
		
		for cell_index in range(SIZE):
			cells.append(Player.NONE)
		
		boards.append(cells)
		board_status.append(BoardStatus.PLAYING)
