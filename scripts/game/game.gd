extends Control

onready var game_manager = $GameManager
onready var input_manager = $InputManager
onready var cursor_manager = $CursorManager
onready var main_board = $mainBoard/GridContainer
onready var pause_menu = $PauseMenu

var game_over := false
var paused := false

func _ready():
	cursor_manager.game_manager = game_manager
	game_manager.connect("move_played", self, "_on_move_played")
	game_manager.connect("state_changed", self, "_on_state_changed")
	game_manager.connect(
		"board_finished",
		main_board,
		"finish_board"
	)
	game_manager.connect("game_finished", self, "_on_game_finished")
	input_manager.connect("pause", self, "_on_pause")
	
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
	
	$GameOver/MainMenuButton.connect(
		"focus_entered",
		self,
		"_on_button_focus",
		[$GameOver/MainMenuButton]
	)

	$GameOver/ExitButton.connect(
		"focus_entered",
		self,
		"_on_button_focus",
		[$GameOver/ExitButton]
	)

	$PauseMenu/ResumeButton.connect(
		"focus_entered",
		self,
		"_on_button_focus",
		[$PauseMenu/ResumeButton]
	)

	$PauseMenu/MainMenuButton.connect(
		"focus_entered",
		self,
		"_on_button_focus",
		[$PauseMenu/MainMenuButton]
	)

	_on_state_changed()

func _on_confirm():
	if game_over or paused:
		return
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
	if game_over or paused:
		return
	cursor_manager.move(Vector2.UP)

func _on_move_down():
	if game_over or paused:
		return
	cursor_manager.move(Vector2.DOWN)

func _on_move_left():
	if game_over or paused:
		return
	cursor_manager.move(Vector2.LEFT)

func _on_move_right():
	if game_over or paused:
		return
	cursor_manager.move(Vector2.RIGHT)

func show_win(player):
	$GameOver.show()
	if player == GameState.Player.RASPBERRY:
		$GameOver/ResultLabel.text = "RASPBERRY WINS!"
	elif player == GameState.Player.BLUEBERRY:
		$GameOver/ResultLabel.text = "BLUEBERRY WINS!"


func show_draw():
	$GameOver.show()
	$GameOver/ResultLabel.text = "DRAW!"

func _on_main_menu_button_pressed():
	get_tree().change_scene("res://scenes/screens/MainMenu.tscn")

func _on_exit_button_pressed():
	get_tree().quit()

func _on_game_finished(winner):
	game_over = true
	if winner == GameState.Player.RASPBERRY || winner == GameState.Player.BLUEBERRY:
		show_win(winner)
	else:
		show_draw()
	$GameOver/MainMenuButton.grab_focus()

func toggle_pause():
	if game_over:
		return
	
	paused = !paused
	pause_menu.visible = paused
	
	if paused:
		pause_menu.get_node("ResumeButton").grab_focus()

func _on_pause():
	toggle_pause()

func _on_resume_button_pressed():
	toggle_pause()

func _on_button_focus(button):
	for child in button.get_parent().get_children():
		var line = child.get_node_or_null("FocusLine")
		if line:
			line.hide()
	
	button.get_node("FocusLine").show()
