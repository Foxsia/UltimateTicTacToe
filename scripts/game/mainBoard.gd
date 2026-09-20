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

func update_from_state(state: GameState):
	for i in range(SIZE*SIZE):
		boards[i].update_from_state(state.boards[i])
