class_name SmallBoardView
extends GridContainer

const SIZE := 3
var cells: Array = []

signal board_played(cell)


func _ready():
	columns = SIZE
	
	for i in range (SIZE*SIZE):
		var cell = preload("res://scenes/cell/cell.tscn").instance()
		add_child(cell)
		cells.append(cell)
	
	set_cursor(0)

func update_from_state(board_state: Array):
	for i in range(SIZE*SIZE):
		cells[i].set_player(board_state[i])

func set_active(active: bool):
	modulate = Color.white if active else Color(0.5, 0.5, 0.5)

func update_cell(cell_index, player):
	cells[cell_index].set_player(player)

func set_cursor(cell_index: int):
	for i in range(cells.size()):
		cells[i].set_highlight(i == cell_index)

func set_winner(player: int):
	match player:
		GameState.Player.RASPBERRY:
			modulate = Color(1.0, 0.3, 0.5)

		GameState.Player.BLUEBERRY:
			modulate = Color(0.3, 0.5, 1.0)
