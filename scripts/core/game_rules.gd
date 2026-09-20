class_name GameRules
extends Reference

const WIN_LINES	 := [
	[0, 1, 2],
	[3, 4, 5],
	[6, 7, 8],
	[0, 3, 6],
	[1, 4, 7],
	[2, 5, 8],
	[0, 4, 8],
	[2, 4, 6],
]

static func get_winner(cells: Array) -> int:
	for line in WIN_LINES:
		var a = cells[line[0]]
		var b = cells[line[1]]
		var c = cells[line[2]]
		
		if a != GameState.Player.NONE and a == b and b == c : return a;
	
	return GameState.Player.NONE

static func is_full(cells: Array) -> bool:
	for cell in cells:
		if cell == GameState.Player.NONE: return false
	
	return true

static func can_play(
	state: GameState,
	board_index: int,
	cell_index: int
) -> bool:
	if state.game_over:
		return false
	if board_index < 0 or board_index >= 9:
		return false
	if cell_index < 0 or cell_index >= 9:
		return false
	
	if state.forced_board != -1:
		if board_index != state.forced_board:
			return false
	
	return true
