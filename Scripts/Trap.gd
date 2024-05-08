class_name Trap extends Node2D

signal touchedPlayer

func _on_area_2d_body_entered(body: Node2D):
	if body is Player:
		touchedPlayer.emit()
