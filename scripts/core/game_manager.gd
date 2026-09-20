class_name GameManager
extends Node

signal move_played(board_index, cell_index, player)
signal board_finished(board_index, winner)
signal game_finished(winner)
signal turn_changed(player)
signal state_changed

var state: GameState
var rules := GameRules

func _ready():
	new_game()

func new_game():
	state = GameState.new()
	emit_signal("turn_changed", state.current_player)
	emit_signal("state_changed")

func play_move(board_index: int, cell_index: int) -> bool:
	if not rules.can_play(state, board_index, cell_index):
		return false
	
	var player = state.current_player
	
	state.boards[board_index][cell_index] = player
	
	emit_signal("move_played", board_index, cell_index, player)
	
	var winner = rules.get_winner(
		state.boards[board_index]
	)
	
	if winner != GameState.Player.NONE:
		state.board_status[board_index] = winner
		emit_signal("board_finished", board_index, winner)
	elif rules.is_full(state.boards[board_index]):
		state.board_status[board_index] = GameState.BoardStatus.DRAW
		emit_signal(
			"board_finished",
			board_index,
			GameState.Player.NONE
		)
	
	if check_global_winner():
		state.game_over = true
		emit_signal("game_finished", state.winner)
		emit_signal("state_changed")
		return true
	
	state.forced_board = get_next_board(cell_index)
	
	state.current_player = get_next_player()
	
	emit_signal("turn_changed", state.current_player)
	emit_signal("state_changed")
	
	return true

func get_next_board(cell_index: int) -> int:
	if state.board_status[cell_index] != GameState.BoardStatus.PLAYING:
		return -1
	return cell_index

func get_next_player() -> int:
	if state.current_player == GameState.Player.RASPBERRY:
		return GameState.Player.BLUEBERRY
	return GameState.Player.RASPBERRY

func check_global_winner() -> bool:
	var winners := []
	
	for status in state.board_status:
		if status == GameState.Player.RASPBERRY:
			winners.append(GameState.Player.RASPBERRY)
		elif status == GameState.Player.BLUEBERRY:
			winners.append(GameState.Player.BLUEBERRY)
		else:
			winners.append(GameState.Player.NONE)
	
	var winner = rules.get_winner(winners)
	
	if winner != GameState.Player.NONE:
		state.winner = winner
		return true
	
	var all_finished := true
	
	for status in state.board_status:
		if status == GameState.BoardStatus.PLAYING:
			all_finished = false
			break
	
	if all_finished:
		state.winner = GameState.Player.NONE
		return true
	
	return false
