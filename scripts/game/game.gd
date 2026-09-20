extends Control
#loading images
var rasp_texture = preload("res://assets/textures/raspberry.png")
var blue_texture = preload("res://assets/textures/blueberry.png")

var cursor_x = 0
var cursor_y = 0
const GRID_SIZE = 9

var current_player = "rasp"
var forced_board = -1

onready var main_board = $centerMainBoard/MainBoard

func _ready():
	main_board.connect("move_played", self, "_on_move")
	init_game()


func _on_move(board_index, cell_index):
	if forced_board != -1 and board_index != forced_board:
		return

	var board = main_board.boards[board_index]
	var cell = board.cells[cell_index]

	if current_player == "rasp":
		cell.play("rasp", rasp_texture)
		current_player = "blue"
	else:
		cell.play("blue", blue_texture)
		current_player = "rasp"

	forced_board = cell_index

func init_game():
	var board = $centerMainBoard
	board.anchor_left = 0.5
	board.anchor_top = 0.5
	board.anchor_right = 0.5
	board.anchor_bottom = 0.5
	
	board.rect_position = board.rect_size / 2
	board.rect_position.y -= 50


func _input(event):
	if event.is_action_pressed("move_up"):
		cursor_y = max(0, cursor_y - 1)
	if event.is_action_pressed("move_down"):
		cursor_y = min(GRID_SIZE-1, cursor_y+1)
	if event.is_action_pressed("move_left"):
		cursor_x = max(0, cursor_x - 1)
	if event.is_action_pressed("move_right"):
		cursor_x = min(GRID_SIZE-1, cursor_x+1)
	if event.is_action_pressed("confirm"):
		play_cell()
	update_cursor()

func update_cursor():
	for y in range(GRID_SIZE):
		for x in range(GRID_SIZE):
			var cell = main_board.get_cell(x,y)
			
			if x == cursor_x and y == cursor_y:
				cell.highlight(true)
			else:
				cell.highlight(false)

func play_cell():

	var cell = main_board.get_cell(cursor_x, cursor_y)

	if cell.cell_owner != null:
		return

	if current_player == "rasp":
		cell.play("rasp", rasp_texture)
		current_player = "blue"
	else:
		cell.play("blue", blue_texture)
		current_player = "rasp"
