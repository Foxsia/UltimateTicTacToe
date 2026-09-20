class_name SmallBoardView
extends GridContainer

const SIZE := 3
var cells: Array = []

signal board_played(cell)


# Called when the node enters the scene tree for the first time.
func _ready():
	columns = SIZE
	
	for i in range (SIZE*SIZE):
		var cell = preload("res://scenes/cell/cell.tscn").instance()
		add_child(cell)
		cells.append(cell)

func update_from_state(board_state: Array):
	for i in range(SIZE*SIZE):
		cells[i].set_player(board_state[i])

func set_active(active: bool):
	modulate = Color.white if active else Color(0.5, 0.5, 0.5)

func update_cell(cell_index, player):
	cells[cell_index].set_player(player)
