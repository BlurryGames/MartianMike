class_name HUD extends Control

func setTimeLabel(value: int)-> void:
	$TimeLabel.text = "TIME: " + str(value)
