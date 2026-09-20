extends GridContainer

const SIZE = 3
var cells = []
var winner = null

signal board_played(cell)


# Called when the node enters the scene tree for the first time.
func _ready():
	columns = SIZE
	
	
	for i in range (SIZE*SIZE):
		var cell = preload("res://scenes/cell.tscn").instance()
		add_child(cell)
		cells.append(cell)
		
		cell.connect("played", self, "_on_cell_played")

func _on_cell_played(cell):
	emit_signal("board_played", cell)
	check_winner()

func check_winner():
	var combos = [
		[0,1,2], [3,4,5],[6,7,8],
		[0,3,6],[1,4,7], [2,5,8],
		[0,4,8],[2,4,6]
	]
	
	for com in combos:
		var firstCell = cells[com[0]].cell_owner
		var secondCell = cells[com[1]].cell_owner
		var thirdCell = cells[com[2]].cell_owner
		
		if(firstCell != null and secondCell == firstCell and secondCell == thirdCell):
			winner = firstCell
			print(winner)
