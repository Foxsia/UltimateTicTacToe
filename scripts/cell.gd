extends Control

onready var texture_rect = $TextureRect

var cell_owner = null

signal played(cell)

func play(player, texture):
	if cell_owner != null:
		return
	cell_owner = player
	texture_rect.texture = texture
	emit_signal("played", self) 

func highlight(active):
	if active:
		modulate = Color(1,1,0)
	else:
		modulate = Color(1,1,1)

